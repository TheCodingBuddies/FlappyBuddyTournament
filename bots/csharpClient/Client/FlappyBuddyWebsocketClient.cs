using System.Net.WebSockets;
using System.Text;
using System.Text.Json;
using CsClient.Bots;
using CsClient.Bots.Internal;

namespace CsClient.CsharpClient
{
    public class FlappyBuddyWebsocketClient : IDisposable
    {
        public event EventHandler? OnOpen;
        public event EventHandler? OnClose;

        private readonly UTF8Encoding _encoding = new();
        private readonly IBot _bot;
        private ClientWebSocket? _webSocket;

        /// <summary>
        /// Verbindet mit Zielurl
        /// </summary>
        public async Task Connect(string uri)
        {
            await ConnectInternal(new Uri($"{uri}/{_bot.Name}")).ConfigureAwait(false);
        }

        /// <summary>
        /// Verbindet mit Zielurl
        /// </summary>
        public async Task Connect(Uri uri)
        {
            await ConnectInternal(new Uri(uri, _bot.Name)).ConfigureAwait(false);
        }

        /// <summary>
        /// Verbindet mit Zielurl
        /// </summary>
        /// <param name="uri">muss den Botnamen enthalten</param>
        private async Task ConnectInternal(Uri uri) 
        {
            _webSocket?.Dispose();
            _webSocket = new();
            await _webSocket.ConnectAsync(uri, CancellationToken.None).ConfigureAwait(false);

            await using (var webSocketStream = WebSocketStream.CreateReadableMessageStream(_webSocket))
            {
                var initialMessage = new byte[4];
                await webSocketStream.ReadExactlyAsync(initialMessage, offset: 0, count: 4).ConfigureAwait(false);
                Console.WriteLine($"Initial message: {_encoding.GetString(initialMessage)}");
            }

            OnOpen?.Invoke(this, EventArgs.Empty);
            await ListenAsync().ConfigureAwait(false);
        }

        /// <summary>
        /// Trennt die Verbindung zum Flappy Buddy Server.
        /// </summary>
        public async Task DisconnectAsync()
        {
            if (_webSocket is ClientWebSocket webSocket)
            {
                await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Normal Closure", CancellationToken.None)
                    .ConfigureAwait(false);
                webSocket.Dispose();
            }
            OnClose?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Empfängt den aktuellen Zustand des Spiels.
        /// </summary>
        private static async Task<PlayState?> ReceivePlayStateAsync(WebSocket webSocket)
        {
            await using var webSocketStream = WebSocketStream.CreateReadableMessageStream(webSocket);
            PlayState? playState;
            try
            {
                playState = await JsonSerializer.DeserializeAsync<PlayState>(webSocketStream);
            }
            catch (Exception e)
            {
                Console.WriteLine($"Fehler: {e}");
                return null;
            }
            
#if DEBUG
            Console.WriteLine($"Receive: {JsonSerializer.Serialize(playState)}");
#endif
            return playState;
        }

        /// <summary>
        /// Sendet das Ergebnis des Spielzugs an den Flappy Buddy Server.
        /// </summary>
        private async Task SendResponseAsync(WebSocket webSocket, bool playResult)
        {
            await using var writeStream =
                WebSocketStream.CreateWritableMessageStream(webSocket, WebSocketMessageType.Text);
            var responseMessage = CreateResponseMessage(playResult);
            
#if DEBUG
            Console.WriteLine($"Send: {responseMessage}");
#endif
            await writeStream.WriteAsync(_encoding.GetBytes(responseMessage)).ConfigureAwait(false);
        }

        private async Task ListenAsync()
        {
            while (_webSocket?.State == WebSocketState.Open)
            {
                var playState = await ReceivePlayStateAsync(_webSocket).ConfigureAwait(false);
                var playResult = _bot.Play(playState);
                await SendResponseAsync(_webSocket, playResult).ConfigureAwait(false);
            }
        }

        /// <summary>
        /// Erzeugt die Antwort für den Server.
        /// </summary>
        private static string CreateResponseMessage(bool fly)
        {
            return JsonSerializer.Serialize(new {fly});
        }
        
        public FlappyBuddyWebsocketClient(IBot bot)
        {
            _bot = bot;
        }

        public void Dispose()
        {
            _webSocket?.Dispose();
        }
    }
}
