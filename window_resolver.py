from login_window import LoginWindow
from player_ui import MiniPlayerUI
from settings_window import SettingsWindow
from selection_windows.genre_selection_window import GenreSelectionWindow
from selection_windows.artist_selection_window import ArtistSelectionWindow
from selection_windows.track_selection_window import TrackSelectionWindow
from sqlite_adapter import SqliteAdapter

WELCOME_WINDOWS = [GenreSelectionWindow, ArtistSelectionWindow, TrackSelectionWindow]
SELECTED_IDS = [[] for _ in range(len(WELCOME_WINDOWS))]

class WindowResolver:
    def __init__(self):
        self.db = SqliteAdapter()

    def activate_player(self, user_id):
        self.player_ui = MiniPlayerUI(user_id, self)
        self.player_ui.show()

    def activate_login(self):
        if "player_ui" in self.__dict__:
            self.player_ui.hide()
        self.login_window = LoginWindow(self)
        self.login_window.show()

    def activate_welcome(self, user_id):
        self.user_id = user_id
        self.next_welcome_window = WELCOME_WINDOWS[0](user_id, self, [])
        self.next_welcome_window.show()

    def activate_settings(self, user_id):
        self.settings_window = SettingsWindow(user_id, self)
        self.settings_window.show()

    def next_window(self, current, selected):
        window_id = -1
        for i, window in enumerate(WELCOME_WINDOWS):
            if isinstance(current, window):
                window_id = i
                break

        SELECTED_IDS[i] = selected
        
        current.hide()
        if window_id == len(WELCOME_WINDOWS) -1:
            self.activate_player(self.user_id)
        else:
            self.next_welcome_window = WELCOME_WINDOWS[i+1](self.user_id, self, selected)
            self.next_welcome_window.show()

    def previous_window(self, current):
        window_id = -1
        for i, window in enumerate(WELCOME_WINDOWS):
            if isinstance(current, window):
                window_id = i
                break
        
        current.hide()
        if window_id == 0:
            self.activate_login()
        else:
            selected = SELECTED_IDS[i-1]
            self.next_welcome_window = WELCOME_WINDOWS[i-1](self.user_id, self, selected)
            self.next_welcome_window.show()
