from PyQt6.QtWidgets import QWidget, QLabel, QPushButton, QHBoxLayout

class TrackWidget(QWidget):
    def __init__(self, track, author, genre, id, user_id):
        super().__init__()

        self.id = id
        self.user_id = user_id

        self.label = QLabel('{} - {} ({})'.format(track, author, genre))
        self.button = QPushButton('x')

        self.layout = QHBoxLayout()
        self.layout.addWidget(self.label)
        self.layout.addStretch()
        self.layout.addWidget(self.button)
        self.setLayout(self.layout)

    def remove_from_library(self):
        pass
