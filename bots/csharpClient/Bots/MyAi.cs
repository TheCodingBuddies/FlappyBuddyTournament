using CsClient.Bots.Internal;

namespace CsClient.Bots
{
    public class MyAi : IBot
    {
        /// <inheritdoc/>
        public string Name { get; }

        private bool _fly = true;

        /// <inheritdoc/>
        public bool Play(PlayState? playState)
        {
            // put your logic here
            return _fly;
        }

        public MyAi()
        {
            // give your bot a super duper cool name
            Name = "YourNameHere";
        }
    }
}