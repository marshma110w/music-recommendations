from PyQt6.QtWidgets import QWidget, QPushButton, QHBoxLayout
from pg_adapter import PGAdapter


class LikeButton(QWidget):

    FILLED_HEART = "♥︎"
    EMPTY_HEART = "♡"

    def __init__(self, song_id, user_id, liked):
        super().__init__()

        self.db = PGAdapter()

        self.liked = liked
        self.song_id = song_id
        self.user_id = user_id

        self.button = QPushButton(self.EMPTY_HEART)
        self.update_symbol()

        self.layout = QHBoxLayout()
        self.layout.addWidget(self.button)
        self.setLayout(self.layout)

        self.button.clicked.connect(self.click)

    def click(self):
        self.liked = not self.liked
        self.db_operation()
        self.update_symbol()
    

    def update_symbol(self):
        if self.liked:
            symbol = self.FILLED_HEART
        else:
            symbol = self.EMPTY_HEART
        
        self.button.setText(symbol)
    
    def db_operation(self):
        if self.liked:
            self.db.like(self.song_id, self.user_id)
        else:
            self.db.unlike(self.song_id, self.user_id)
