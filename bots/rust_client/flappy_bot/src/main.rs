use async_trait::async_trait;
use flappy_lib::{FlappyBot, FlappyConsumer, PlayState, Trigger};
use tracing::subscriber;
use tracing_subscriber::filter::LevelFilter;
use tracing_subscriber::FmtSubscriber;

struct MyFlappyConsumer;

#[async_trait]
impl FlappyConsumer for MyFlappyConsumer {
    async fn handle_message(&mut self, play_state: PlayState) -> Trigger {
        // Debug output for visibility
        tracing::debug!("{:?}", play_state);

        // Determine if the player should fly based on their position
        let fly = matches!(play_state.player.pos_y, 450.0..=f32::INFINITY)
            || play_state.player.pos_y < 50.0;

        Trigger { fly } // Return the Trigger message back out to the server
    }
}

#[tokio::main]
async fn main() {
    let subscriber = FmtSubscriber::builder()
        .with_max_level(LevelFilter::TRACE)
        .finish();

    subscriber::set_global_default(subscriber).expect("setting default subscriber failed");

    let url = "wss://echo.websocket.org";
    let name = "Grouvie";

    if let Err(error) = FlappyBot.start(url, name, MyFlappyConsumer).await {
        tracing::error!("{error}");
    };
}
