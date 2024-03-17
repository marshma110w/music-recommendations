from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel, QStackedLayout,
                             QListWidgetItem, QHBoxLayout, QLineEdit, QMessageBox
                            )

from pg_adapter import PGAdapter
from player_ui import MiniPlayerUI
import re


class LoginWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Авторизация")
        self.resize(300, 100)

        self.db = PGAdapter()

        self.layout = QVBoxLayout()
        self.login_label = QLabel("Логин")
        self.password_label = QLabel("Пароль")
        self.login_input = QLineEdit()
        self.password_input = QLineEdit()
        self.login_layout = QHBoxLayout()
        self.password_layout = QHBoxLayout()
        self.login_layout.addWidget(self.login_label)
        self.login_layout.addWidget(self.login_input)
        self.password_layout.addWidget(self.password_label)
        self.password_layout.addWidget(self.password_input)

        self.password_input.setFixedWidth(200)
        self.login_input.setFixedWidth(200)

        self.login_button = QPushButton("Вход")
        self.register_button = QPushButton("Регистрация")
        self.login_button.setEnabled(False)
        self.register_button.setEnabled(False)
        self.buttons_layout = QHBoxLayout()
        self.buttons_layout.addWidget(self.login_button)
        self.buttons_layout.addWidget(self.register_button)

        self.authorize_layout = QVBoxLayout()
        self.authorize_layout.addLayout(self.login_layout)
        self.authorize_layout.addLayout(self.password_layout)
        self.authorize_layout.addStretch()
        self.authorize_layout.addLayout(self.buttons_layout)

        self.centralWidget = QWidget()
        self.centralWidget.setLayout(self.authorize_layout)
        self.setCentralWidget(self.centralWidget)

        self.register_button.clicked.connect(self.register)
        self.login_button.clicked.connect(self.login)
        self.login_input.textChanged.connect(self.check_buttons)
        self.password_input.textChanged.connect(self.check_buttons)


    def login(self):
        login, password = self.get_credentials()
        if not self.db.user_exists(login):
            QMessageBox.warning(self, "Предупреждение", "Пользователя не существует")
            return
        
        if not self.db.authenticate(login, password):
            QMessageBox.warning(self, "Предупреждение", "Пароль неверный!")
            return

        self.authorize(login)

    
    def register(self):
        login, password = self.get_credentials()
        if self.db.user_exists(login):
            QMessageBox.warning(self, "Предупреждение", "Логин уже занят")
            return

        if not self.validate_password(password):
            QMessageBox.warning(self, "Предупреждение", "Пароль должен быть не менее 8 символов и содержать по крайней мере "
                "одну заглавную букву латинского алфавита, одну строчную букву латинского алфавита и одну цифру")
            return
        
        self.db.create_user(login, password)
        self.authorize(login)


    def get_credentials(self):
        login = self.login_input.text()
        password = self.password_input.text()
        return login, password
    

    def check_buttons(self):
        login, password = self.get_credentials()
        if login and password:
            self.login_button.setEnabled(True)
            self.register_button.setEnabled(True)

    
    def validate_password(self, password):
        pattern = re.compile(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[\S]{8,}$")
        return bool(pattern.match(password))
    

    def authorize(self, login):
        user_id = self.db.id_by_login(login)
        
        self.player_window = MiniPlayerUI(user_id)
        self.player_window.show()
        self.hide()
