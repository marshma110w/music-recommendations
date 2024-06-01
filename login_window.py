from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel, QStackedLayout,
                             QListWidgetItem, QHBoxLayout, QLineEdit, QMessageBox
                            )

from sqlite_adapter import SqliteAdapter
import re


class LoginWindow(QMainWindow):
    def __init__(self, resolver):
        super().__init__()
        self.setStyleSheet("background-color: darkkhaki")

        self.resize(600, 100)

        self.resolver = resolver

        self.db = SqliteAdapter()

        self.layout = QStackedLayout()
        self.layout.addWidget(self.construct_login_page())
        self.layout.addWidget(self.construct_registration_page())


        self.centralWidget = QWidget()
        self.centralWidget.setLayout(self.layout)
        self.setCentralWidget(self.centralWidget)
        self.to_login()

    def construct_login_page(self):
        self.auth_login_label = QLabel("Логин")
        self.auth_login_label.setStyleSheet("color: black")
        self.auth_password_label = QLabel("Пароль")
        self.auth_password_label.setStyleSheet("color: black")
        self.auth_login_input = QLineEdit()
        self.auth_login_input.setStyleSheet("color: black; background-color: white")
        self.auth_password_input = QLineEdit()
        self.auth_password_input.setStyleSheet("color: black; background-color: white")
        self.auth_password_input.setEchoMode(QLineEdit.EchoMode.Password)
        self.auth_login_layout = QHBoxLayout()
        self.auth_password_layout = QHBoxLayout()
        self.auth_login_layout.addWidget(self.auth_login_label)
        self.auth_login_layout.addWidget(self.auth_login_input)
        self.auth_password_layout.addWidget(self.auth_password_label)
        self.auth_password_layout.addWidget(self.auth_password_input)

        self.auth_password_input.setFixedWidth(200)
        self.auth_login_input.setFixedWidth(200)

        self.login_button = QPushButton("Вход")
        self.login_button.setStyleSheet("background-color: darkorange; color: black")
        self.register_link = QLabel(
            '<a href="#" style="text-decoration: none;">Регистрация</a>'
        )
        self.login_button.setEnabled(False)
        self.buttons_layout = QVBoxLayout()
        self.buttons_layout.addWidget(self.login_button)
        self.reg_link_layout = QHBoxLayout()
        self.reg_link_layout.addStretch()
        self.reg_link_layout.addWidget(self.register_link)
        self.buttons_layout.addLayout(self.reg_link_layout)

        self.authorize_layout = QVBoxLayout()
        self.authorize_layout.addLayout(self.auth_login_layout)
        self.authorize_layout.addLayout(self.auth_password_layout)
        self.authorize_layout.addStretch()
        self.authorize_layout.addLayout(self.buttons_layout)
        
        self.login_page = QWidget()
        self.login_page.setLayout(self.authorize_layout)

        self.register_link.linkActivated.connect(self.to_registration)
        self.login_button.clicked.connect(self.login)
        self.auth_login_input.textChanged.connect(self.check_buttons)
        self.auth_password_input.textChanged.connect(self.check_buttons)
        
        return self.login_page
    
    def construct_registration_page(self):
        self.reg_layout = QVBoxLayout()

        self.reg_login_layout = QHBoxLayout()
        self.reg_login_label = QLabel("Логин")
        self.reg_login_label.setStyleSheet("color: black")
        self.reg_login_input = QLineEdit()
        self.reg_login_input.setStyleSheet("color: black;background-color: white")
        self.reg_login_input.setFixedWidth(200)
        self.reg_login_layout.addWidget(self.reg_login_label)
        self.reg_login_layout.addStretch()
        self.reg_login_layout.addWidget(self.reg_login_input)

        self.reg_layout.addLayout(self.reg_login_layout)

        self.reg_password_layout = QHBoxLayout()
        self.reg_password_label = QLabel("Пароль")
        self.reg_password_label.setStyleSheet("color: black")
        self.reg_password_input = QLineEdit()
        self.reg_password_input.setStyleSheet("color: black;background-color: white")
        self.reg_password_input.setEchoMode(QLineEdit.EchoMode.Password)
        self.reg_password_input.setFixedWidth(200)
        self.reg_password_layout.addWidget(self.reg_password_label)
        self.reg_password_layout.addStretch()
        self.reg_password_layout.addWidget(self.reg_password_input)

        self.reg_layout.addLayout(self.reg_password_layout)

        self.reg_password2_layout = QHBoxLayout()
        self.reg_password2_label = QLabel("Подтверждение")
        self.reg_password2_label.setStyleSheet("color: black")
        self.reg_password2_input = QLineEdit()
        self.reg_password2_input.setStyleSheet("color: black;background-color: white")
        self.reg_password2_input.setEchoMode(QLineEdit.EchoMode.Password)
        self.reg_password2_input.setFixedWidth(200)
        self.reg_password2_layout.addWidget(self.reg_password2_label)
        self.reg_password2_layout.addStretch()
        self.reg_password2_layout.addWidget(self.reg_password2_input)

        self.reg_layout.addLayout(self.reg_password2_layout)

        self.registration_button = QPushButton("Зарегистрироваться")
        self.registration_button.setStyleSheet("background-color: darkorange; color: black")
        self.reg_layout.addWidget(self.registration_button)
        
        self.back_layout = QHBoxLayout()
        self.login_link = QLabel(
            '<a href="#" style="text-decoration: none;">Уже есть аккаунт?</a>'
        )
        self.back_layout.addStretch()
        self.back_layout.addWidget(self.login_link)
        self.reg_layout.addLayout(self.back_layout)

        self.registration_page = QWidget()
        self.registration_page.setLayout(self.reg_layout)

        self.login_link.linkActivated.connect(self.to_login)
        self.registration_button.clicked.connect(self.register)

        return self.registration_page


    def login(self):
        login, password = self.get_auth_credentials()
        if not self.db.user_exists(login):
            QMessageBox.warning(self, "Предупреждение", "Пользователя не существует")
            return
        
        if not self.db.authenticate(login, password):
            QMessageBox.warning(self, "Предупреждение", "Пароль неверный!")
            return

        self.authorize(login)

    
    def register(self):
        login, password, password2  = self.get_reg_credentials()
        
        if password != password2:
            QMessageBox.warning(self, "Предупреждение", "Пароли не совпадают")
            return
        
        if not self.validate_login(login):
            QMessageBox.warning(self, "Предупреждение", "Логин должен быть от 3 до 15 символов и должен содержать "
                "буквы латинского алфавита. Также допускаются цифры, подчеркивание, точка или дефис.")
            return

        if not self.validate_password(password):
            QMessageBox.warning(self, "Предупреждение", "Пароль должен быть не менее 8 символов и содержать по крайней мере "
                "одну заглавную букву латинского алфавита, одну строчную букву латинского алфавита и одну цифру")
            return
        
        if self.db.user_exists(login):
            QMessageBox.warning(self, "Предупреждение", "Логин уже занят")
            return
        
        self.db.create_user(login, password)
        self.authorize(login, new_user=True)


    def get_auth_credentials(self):
        login = self.auth_login_input.text()
        password = self.auth_password_input.text()
        return login, password
    
    def get_reg_credentials(self):
        login = self.reg_login_input.text()
        password = self.reg_password_input.text()
        password2 = self.reg_password2_input.text()
        return login, password, password2
    

    def check_buttons(self):
        login, password = self.get_auth_credentials()
        if login and password:
            self.login_button.setEnabled(True)

    
    def validate_password(self, password):
        pattern = re.compile(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[\S]{8,}$")
        return bool(pattern.match(password))
    
    def validate_login (self, login):
        pattern = re.compile(r"^[a-zA-Z0-9_.-]{3,15}$")
        return bool(pattern.match(login))

    def authorize(self, login, new_user=False):
        user_id = self.db.id_by_login(login)
        if new_user:
            self.resolver.activate_welcome(user_id)
        else:
            self.resolver.activate_player(user_id)
        self.hide()

    def to_registration(self):
        self.set_page(1)
        self.setWindowTitle("Регистрация")

    def to_login(self):
        self.set_page(0)
        self.setWindowTitle("Аутентификация")

    def set_page(self, index):
        self.layout.setCurrentIndex(index)
