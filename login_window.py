from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel, QStackedLayout,
                             QListWidgetItem, QHBoxLayout, QLineEdit
                            )

from pg_adapter import PGAdapter
from player_ui import MiniPlayerUI

import ipdb

class LoginWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Авторизация")
        self.resize(400, 300)

        self.db = PGAdapter()

        self.layout = QVBoxLayout()
        self.main_label = QLabel("Выберите ваш логин")
        self.users_list = QListWidget()
        self.fill_users_list()
        self.users_list.clicked.connect(self.select_user)

        self.new_user_layout = QHBoxLayout()
        self.new_user_login_field = QLineEdit()
        self.new_user_button = QPushButton("Создать нового пользователя")
        self.new_user_button.clicked.connect(self.create_new_user)

        self.new_user_layout.addWidget(self.new_user_login_field)
        self.new_user_layout.addStretch()
        self.new_user_layout.addWidget(self.new_user_button)

        self.layout.addWidget(self.main_label)
        self.layout.addWidget(self.users_list)
        self.layout.addStretch()
        self.layout.addLayout(self.new_user_layout)

        self.centralWidget = QWidget()
        self.centralWidget.setLayout(self.layout)
        self.setCentralWidget(self.centralWidget)

    
    def fill_users_list(self):
        users = self.db.users()
        self.id_by_login = {}
        for record in users:
            self.id_by_login[record[0]] = record[1]
            self.users_list.addItem(record[0])


    def create_new_user(self):
        login = self.new_user_login_field.text()
        new_user_id = self.db.create_user(login)
        ipdb.set_trace()

        self.to_player(login, new_user_id)


    def select_user(self):
        login = self.users_list.selectedItems()[0].text()
        id = self.id_by_login[login]
        self.to_player(login, id)


    def to_player(self, login, id):
        self.player_window = MiniPlayerUI(login, id)
        self.player_window.show()
        self.hide()