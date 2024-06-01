from PyQt6.QtWidgets import (QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel,
                             QListWidgetItem, QHBoxLayout,
                            )
from PyQt6.QtCore import Qt


class BaseSelectionWindow(QMainWindow):
    def __init__(self, user_id, resolver, selected_previous):
        super().__init__()
        self.user_id = user_id
        self.resolver = resolver
        self.selected_previous = selected_previous
        self.resize(600, 800)
        self.setStyleSheet("background-color: darkkhaki; color: black")

        self.selection_layout = QVBoxLayout()

        self.title_layout = QHBoxLayout()
        self.selection_title = QLabel(f"Выберите {self.selection_object()}, которые вам нравятся")
        self.back_button = QPushButton("Назад")
        self.back_button.setStyleSheet("background-color: darkorange")
        self.back_button.clicked.connect(self.back)
        self.list = QListWidget()
        self.list.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self.submit_button = QPushButton('Далее')
        self.submit_button.setStyleSheet("background-color: darkorange")
        self.submit_button.clicked.connect(self.submit)
        self.fill_list()

        self.title_layout.addWidget(self.selection_title)
        self.title_layout.addStretch()
        self.title_layout.addWidget(self.back_button)
        self.selection_layout.addLayout(self.title_layout)
        self.selection_layout.addWidget(self.list)
        self.selection_layout.addWidget(self.submit_button)
        self.main_widget = QWidget()
        self.main_widget.setLayout(self.selection_layout)
        self.setCentralWidget(self.main_widget)


    def fill_list(self):
        for item in self.get_data():
            list_item = QListWidgetItem(self.list)
            object = self.widget(*item)
            list_item.setSizeHint(object.sizeHint())
            self.list.setItemWidget(list_item, object)

    def collect_selected_ids(self):
        selected_ids = []
        for item in self.list.findItems('', Qt.MatchFlag.MatchContains):
            object = self.list.itemWidget(item)
            if object.checked():
                selected_ids.append(object.id)
        return selected_ids

    def submit(self):
        self.save_data()
        self.resolver.next_window(self, self.selected)

    def back(self):
        self.resolver.previous_window(self)

    def widget(self, *args):
        raise NotImplementedError

    def get_data(self):
        raise NotImplementedError

    def save_data(self):
        raise NotImplementedError

    def selection_object(self):
        raise NotImplementedError
