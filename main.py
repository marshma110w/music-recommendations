import sys
from PyQt6.QtWidgets import QApplication
from login_window import LoginWindow

# Запуск приложения
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = LoginWindow()
    window.show()
    sys.exit(app.exec())
