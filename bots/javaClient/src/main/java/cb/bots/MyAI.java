package cb.bots;

import cb.PlayState;

public class MyAI implements BotAi {
//  todo: give your bot a super duper cool name
    private String name = "YourBotName";
    private boolean fly = true;

    public MyAI() {
    }

    @Override
    public boolean play(PlayState playState) {
//      todo: put your logic code here
        return fly;
    }

    @Override
    public String getName() {
        return name;
    }
}
