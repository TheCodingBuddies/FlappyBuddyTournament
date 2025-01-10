package cb.bots;

import cb.PlayState;

public interface BotAi {

    boolean play(PlayState playState);

    String getName();
}
