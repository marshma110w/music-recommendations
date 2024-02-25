from PyQt6.QtWidgets import QWidget, QLabel, QPushButton, QHBoxLayout, QCheckBox

class WelcomeSongWidget(QWidget):
    def __init__(self, name, artist, genre, external_id, id):
        super().__init__()
    
        self.name = name
        self.artist = artist
        self.id = id
        self.external_id = external_id
        self.genre = genre

        self.label = QLabel('{} - {} ({})'.format(artist, name, genre))
        self.checkbox = QCheckBox()

        self.layout = QHBoxLayout()
        self.layout.addWidget(self.label)
        self.layout.addStretch()
        self.layout.addWidget(self.checkbox)
        self.setLayout(self.layout)

    def checked(self):
        return self.checkbox.isChecked()
