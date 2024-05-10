from login_window import LoginWindow
from player_ui import MiniPlayerUI

class WindowResolver:
    def activate_player(self, user_id):
        self.player_ui = MiniPlayerUI(user_id, self)
        self.player_ui.show()

    def activate_login(self):
        self.login_window = LoginWindow(self)
        self.login_window.show()

