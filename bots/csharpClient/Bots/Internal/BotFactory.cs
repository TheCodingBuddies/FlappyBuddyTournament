using System.Reflection;

namespace CsClient.Bots.Internal
{
    public class BotFactory
    {
        public static IBot GetBotByName(string botName)
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            string className = $"{nameof(CsClient)}.{nameof(Bots)}.{botName}";

            Type? type = assembly.GetType(className);
            if (type is null)
            {
                return new MyAi();
            }
            else
            {
                var instance = Activator.CreateInstance(type) as IBot;
                return instance ?? new MyAi();
            }
        }
    }
}