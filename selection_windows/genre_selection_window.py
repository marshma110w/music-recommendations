from abstract_selection_window import AbstractSelectionWindow
from widgets.genre_widget import GenreWidget
from sqlite_adapter import SqliteAdapter


class GenreSelectionWindow(AbstractSelectionWindow):
    def __init__(self, *args):
        super().__init__(*args)

    def widget(self, *args):
        return GenreWidget(*args)
    
    def get_data(self):
        return SqliteAdapter().genres()
    
    def save_data(self):
        self.selected = self.collect_selected_ids()

    def selection_object(self):
        return "жанры"
