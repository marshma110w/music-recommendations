from PyQt6.QtWidgets import QWidget, QLabel, QPushButton, QHBoxLayout

class TrackWidget(QWidget):
    def __init__(self, track, author, genre, id, user_id, button_options):
        super().__init__()

        self.buttons = []
        self.config_buttons(button_options)

        self.id = id
        self.user_id = user_id

        self.label = QLabel('{} - {} ({})'.format(track, author, genre))

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

            if option == "delete":
                self.delete_button = QPushButton("x")
                self.buttons.append(self.delete_button)
            
            if option == "like":
                self.like_button = QPushButton("like")
                self.buttons.append(self.like_button)
            
            if option == "dislike":
                self.dislike_button = QPushButton("dislike")
                self.buttons.append(self.dislike_button)

            if option == "play":
                self.play_button = QPushButton("play")
                self.buttons.append(self.play_button)
