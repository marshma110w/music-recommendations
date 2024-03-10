import sys
from PyQt6.QtWidgets import QApplication, QWidget, QLabel, QPushButton, QHBoxLayout

class CustomWidget(QWidget):
    def __init__(self, text, button_text):
        super().__init__()

        # Создаем экземпляры QLabel и QPushButton с предоставленным текстом
        self.label = QLabel(text)
        self.button = QPushButton(button_text)

        # Создаем горизонтальный макет
        self.layout = QHBoxLayout()

        # Добавляем виджеты в макет
        self.layout.addWidget(self.label)
        self.layout.addWidget(self.button)

        # Применяем макет к пользовательскому виджету
        self.setLayout(self.layout)

# Создаем приложение и пример нашего кастомного виджета
app = QApplication(sys.argv)
window = QWidget()
custom_widget = CustomWidget("Пример текста", "Кнопка")

# Ваш кастомный виджет теперь можно использовать как любой другой виджет PyQt
# Например, можно добавить его в макет окна
layout = QHBoxLayout(window)
layout.addWidget(custom_widget)

window.setLayout(layout)
window.show()

sys.exit(app.exec())