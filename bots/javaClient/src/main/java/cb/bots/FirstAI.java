package cb.bots;

import cb.PlayState;

public class FirstAI implements BotAi {
    private String name = "JavaTestBot";
    private boolean fly = true;

    public FirstAI() {
    }

    @Override
    public boolean play(PlayState playState) {
        if (playState.getPlayer().getPosY() > 450) {
            fly = true;
        }

        if (playState.getPlayer().getPosY() < 50) {
            fly = false;
        }

        return fly;
    }

    @Override
    public String getName() {
        return name;
    }
}
