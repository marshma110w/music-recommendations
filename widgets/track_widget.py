from PyQt6.QtWidgets import QWidget, QLabel, QPushButton, QHBoxLayout
from widgets.like_button_widget import LikeButton

from webbrowser import open as webopen

class TrackWidget(QWidget):
    def __init__(self, track, author, genre, id, ext_id, user_id, liked, button_options):
        super().__init__()

        self.id = id
        self.ext_id = ext_id
        self.user_id = user_id
        self.liked = liked

        self.label = QLabel('{} - {} ({})'.format(track, author, genre))

        self.buttons = []
        self.config_buttons(button_options)

        self.layout = QHBoxLayout()
        self.layout.addWidget(self.label)
        self.layout.addStretch()
        for button in self.buttons:
            self.layout.addWidget(button)

        self.setLayout(self.layout)


    def remove_from_library(self):
        pass

    def config_buttons(self, options):
        for option in options:
            if option == "like":
                self.like_button = LikeButton(self.id, self.user_id, self.liked)
                self.buttons.append(self.like_button)

            if option == "play":
                self.play_button = QPushButton("►")
                self.buttons.append(self.play_button)
                self.play_button.clicked.connect(self.play)

    def play(self):
        href = "https://www.youtube.com/watch?v={}".format(self.ext_id)
        print(href)
        webopen(href)
