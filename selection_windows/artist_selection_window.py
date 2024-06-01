from base_selection_window import BaseSelectionWindow
from widgets.artist_widget import ArtistWidget
from sqlite_adapter import SqliteAdapter


class ArtistSelectionWindow(BaseSelectionWindow):
    def widget(self, *args):
        return ArtistWidget(*args)
    
    def get_data(self):
        return SqliteAdapter().artists_by_genres(self.selected_previous)
    
    def save_data(self):
        self.selected = self.collect_selected_ids()

    def selection_object(self):
        return "исполнителей"
