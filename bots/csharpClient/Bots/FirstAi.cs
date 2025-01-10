using CsClient.Bots.Internal;

namespace CsClient.Bots
{
    public class FirstAi : IBot
    {
        /// <inheritdoc/>
        public string Name { get; }

        private bool _fly;

        /// <inheritdoc/>
        public bool Play(PlayState? playState)
        {
            if (playState?.Player.PosY > 450)
            {
                _fly = true;
            }

            if (playState?.Player.PosY < 50)
            {
                _fly = false;
            }

            return _fly;
        }

        public FirstAi()
        {
            Name = "TestCsharpBot";
        }
    }
}