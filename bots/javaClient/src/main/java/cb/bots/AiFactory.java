package cb.bots;

public class AiFactory {
     public static BotAi create(String type) {
         switch (type) {
             case "FirstAI":
                 return new FirstAI();
             default:
                 return new FirstAI();
         }
     }
}
