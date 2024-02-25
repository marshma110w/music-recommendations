from PyQt6.QtWidgets import QWidget, QLabel, QPushButton, QHBoxLayout, QCheckBox

class ArtistWidget(QWidget):
    def __init__(self, name, genre, id):
        super().__init__()
    
        self.name = name
        self.id = id
        self.genre = genre

        self.label = QLabel('{} ({})'.format(name, genre))
        self.checkbox = QCheckBox()

        self.layout = QHBoxLayout()
        self.layout.addWidget(self.label)
        self.layout.addStretch()
        self.layout.addWidget(self.checkbox)
        self.setLayout(self.layout)

    def checked(self):
        return self.checkbox.isChecked()
