import sys
from PyQt6.QtWidgets import QApplication
from window_resolver import WindowResolver

# Запуск приложения
if __name__ == "__main__":
    app = QApplication(sys.argv)
    resolver = WindowResolver()
    resolver.activate_login()
    sys.exit(app.exec())
