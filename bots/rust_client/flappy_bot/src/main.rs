use async_trait::async_trait;
use flappy_lib::{FlappyBot, FlappyConsumer, PlayState, Trigger};
use tracing::subscriber;
use tracing_subscriber::filter::LevelFilter;
use tracing_subscriber::FmtSubscriber;

struct MyFlappyConsumer {
    fly: bool
}

#[async_trait]
impl FlappyConsumer for MyFlappyConsumer {
    async fn handle_message(&mut self, play_state: PlayState) -> Trigger {
        // Debug output for visibility
        tracing::debug!("{:?}", play_state);

        // Determine if the player should fly based on their position
        if play_state.player.pos_y > 450.0 {
            self.fly = true;
        } else if play_state.player.pos_y < 50.0 {
            self.fly = false;
        }

        Trigger { fly: self.fly } // Return the Trigger message back out to the server
    }
}

#[tokio::main]
async fn main() {
    let subscriber = FmtSubscriber::builder()
        .with_max_level(LevelFilter::TRACE)
        .finish();

    subscriber::set_global_default(subscriber).expect("setting default subscriber failed");

    let url = "ws://localhost:5050";
    let name = "RustTestBot";

    let my_flappy_consumer = MyFlappyConsumer {
        fly: false
    };

    if let Err(error) = FlappyBot.start(url, name, my_flappy_consumer).await {
        tracing::error!("{error}");
    };
}
