from Bots.bot_ai import BotAI
from Bots.data import PlayState


class BodenNuckel(BotAI):
    fly = True

    def should_move_up(self, player, enemies):
        safe_space = 15
        top_margin = 20
        headroom = 20
        min_gap_height = 40
        detection_range_x = 430

        player_top = player.pos_y - player.height / 2
        player_bottom = player.pos_y + player.height / 2
        player_left = player.pos_x - player.width / 2
        player_right_detection = player.pos_x + detection_range_x

        player_is_near_top = player_top <= top_margin

        # 1. Prüfen, ob über dem Player ein Gegner ist
        def enemy_above_player(enemy):
            e_top = enemy.origin_y - enemy.height / 2 - safe_space
            e_bottom = enemy.origin_y + enemy.height / 2 + safe_space
            e_left = enemy.origin_x - enemy.width / 2 - safe_space
            e_right = enemy.origin_x + enemy.width / 2 + safe_space

            horizontal_overlap = e_right > player_left and e_left < player_left + player.width
            vertical_overlap = e_top < player_top and e_bottom > player_top - headroom
            return horizontal_overlap and vertical_overlap

        danger_above = any(enemy_above_player(enemy) for enemy in enemies)

        # 2. Gegner in der "Front" sammeln (die vor dem Player im X-Bereich sind)
        front_enemies = []
        for enemy in enemies:
            enemy_x = enemy.origin_x
            enemy_y = enemy.origin_y
            enemy_w = enemy.width
            enemy_h = enemy.height

            enemy_left = enemy_x - enemy_w / 2 - safe_space
            enemy_right = enemy_x + enemy_w / 2 + safe_space
            enemy_top = enemy_y - enemy_h / 2 - safe_space
            enemy_bottom = enemy_y + enemy_h / 2 + safe_space

            # Im X-Erkennungsbereich?
            if enemy_left < player_right_detection and enemy_right > player_left:
                front_enemies.append((enemy_top, enemy_bottom))

                # Gegner kollidiert mit Player? (Y)
                if enemy_top < player_bottom and enemy_bottom > player_top:
                    if not player_is_near_top and not danger_above:
                        print("ausweichen nach oben erlaubt")
                        return True
                    else:
                        print("ausweichen nach oben nicht möglich -> runter")
                        return False

        # 3. Sackgassen-Check: Sind fast alle Y-Bereiche "dicht" vor dem Spieler?
        front_enemies.sort()  # nach Y sortieren

        # prüfen, ob zwischen den Gegnern Platz zum Durchfliegen ist
        last_bottom = 0
        for top, bottom in front_enemies:
            if top - last_bottom >= min_gap_height:
                break  # Es gibt Platz → keine Sackgasse
            last_bottom = max(last_bottom, bottom)
        else:
            # Kein durchgängiger Spalt → Sackgasse
            if player_is_near_top or danger_above:
                return False  # Nach unten ausweichen!

        return False  # Kein Gegner oder keine Kollision → runter

    def move_up(self, player, enemies, detection_range_x):
        player_top = player.pos_y - player.height / 2
        player_bottom = player.pos_y + player.height / 2
        player_left = player.pos_x - player.width / 2
        player_right_detection = player.pos_x + detection_range_x
        safe_space = 20
        top_margin = 20
        headroom = 30
        player_is_near_top = player_top <= top_margin

        def enemy_above_player(enemy):
            e_top = enemy.origin_y - enemy.height / 2 - safe_space
            e_bottom = enemy.origin_y + enemy.height / 2 + safe_space
            e_left = enemy.origin_x - enemy.width / 2 - safe_space
            e_right = enemy.origin_x + enemy.width / 2 + safe_space

            horizontal_overlap = e_right > player_left and e_left < player_left + player.width
            vertical_overlap = e_top < player_top and e_bottom > player_top - headroom
            return horizontal_overlap and vertical_overlap

        danger_above = any(enemy_above_player(enemy) for enemy in enemies)

        for e in enemies:
            enemy_left = e.origin_x - e.width / 2 - safe_space
            enemy_right = e.origin_x + e.width / 2 + safe_space
            enemy_top = e.origin_y - e.height / 2 - safe_space
            enemy_bottom = e.origin_y + e.height / 2 + safe_space

            if enemy_left < player_right_detection and enemy_right > player_left:
                if enemy_top < player_bottom and enemy_bottom > player_top:
                    if not player_is_near_top and not danger_above:
                        return True
                    else:
                        return False

        return False

    def play(self, current_game_state: PlayState):
        enemies = [o for o in current_game_state.obstacles if o.type not in ["Coin", "Finish"]]
        self.fly = self.should_move_up(current_game_state.player, enemies)
        return self.fly

    def get_name(self):
        return self.name

    def __init__(self):
        self.name = "BodenNuckel"
