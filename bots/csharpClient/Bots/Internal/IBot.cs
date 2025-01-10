

// ns is not corret, that is intendet

namespace CsClient.Bots.Internal
{
    public interface IBot
    {
        /// <summary>
        /// Name des Spielers.
        /// </summary>
        string Name { get; }
        /// <summary>
        /// Spielmethode.
        /// </summary>
        /// <param name="playState">Der aktuelle Spielzustand (Obstacles und Player)</param>
        /// <returns>Player soll fliegen oder nicht</returns>
        bool Play(PlayState? playState);

    }
}
