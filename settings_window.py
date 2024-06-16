from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel, QStackedLayout,
                             QListWidgetItem, QHBoxLayout, QGroupBox, QCheckBox
                            )
from sqlite_adapter import SqliteAdapter
from PyQt6.QtCore import Qt



class SettingsWindow(QMainWindow):
    def __init__(self, user_id, resolver):
        super().__init__()
        self.setStyleSheet("background-color: darkkhaki; color: black")
        self.db = SqliteAdapter()
        user_name = self.db.login_by_id(user_id)
        self.resolver = resolver
        self.user_id = user_id
        self.user_name = user_name

        self.setWindowFlags(Qt.WindowType.Window | Qt.WindowType.CustomizeWindowHint | Qt.WindowType.WindowTitleHint | Qt.WindowType.WindowCloseButtonHint)



        self.layout = QVBoxLayout()
        self.log_out_button = QPushButton("Выйти из аккаунта")
        self.log_out_button.setStyleSheet("background-color: darkorange; color: black")
        self.delete_account_button = QPushButton("Удалить аккаунт")
        self.delete_account_button.setStyleSheet("background-color: darkorange; color: black")
        self.back_to_library_button = QPushButton("Назад")
        self.back_to_library_button.setStyleSheet("background-color: darkorange; color: black")

        self.layout.addWidget(self.log_out_button)
        self.layout.addWidget(self.delete_account_button)
        self.layout.addStretch()
        self.layout.addWidget(self.back_to_library_button)

        self.back_to_library_button.clicked.connect(self.back)
        self.log_out_button.clicked.connect(self.log_out)
        self.delete_account_button.clicked.connect(self.delete_account)

        self.main_widget = QWidget()
        self.main_widget.setLayout(self.layout)
        self.setCentralWidget(self.main_widget)

    def back(self):
        self.resolver.activate_player(self.user_id)
        self.hide()


    def delete_account(self):
        self.db.delete_account(self.user_id)
        self.log_out()

    def log_out(self):
        self.resolver.activate_login()
        self.hide()

    