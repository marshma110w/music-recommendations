from login_window import LoginWindow
from player_ui import MiniPlayerUI
from settings_window import SettingsWindow

class WindowResolver:
    def activate_player(self, user_id):
        self.player_ui = MiniPlayerUI(user_id, self)
        self.player_ui.show()

    def activate_login(self):
        if "player_ui" in self.__dict__:
            self.player_ui.hide()
        self.login_window = LoginWindow(self)
        self.login_window.show()

    def activate_settings(self, user_id):
        self.settings_window = SettingsWindow(user_id, self)
        self.settings_window.show()
