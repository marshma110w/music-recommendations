from base_selection_window import BaseSelectionWindow
from widgets.welcome_song_widget import WelcomeSongWidget
from sqlite_adapter import SqliteAdapter


class TrackSelectionWindow(BaseSelectionWindow):
    def widget(self, *args):
        return WelcomeSongWidget(*args)
    
    def get_data(self):
        return SqliteAdapter().tracks_by_artists(self.selected_previous)
    
    def save_data(self):
        self.selected = self.collect_selected_ids()
        SqliteAdapter().like_songs(self.user_id, self.selected)

    def selection_object(self):
        return "песни"
