import sys
from PyQt6.QtWidgets import QApplication, QMainWindow, QListWidget, QListWidgetItem, QLabel, QPushButton, QHBoxLayout, QWidget

class CustomWidget(QWidget):
    def __init__(self, text, button_text):
        super().__init__()
        layout = QHBoxLayout()
        label = QLabel(text)
        button = QPushButton(button_text)
        layout.addWidget(label)
        layout.addWidget(button)
        self.setLayout(layout)

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        
        self.list_widget = QListWidget()
        self.add_custom_widgets(10)  # Добавляем N кастомных виджетов
        self.setCentralWidget(self.list_widget)

    def add_custom_widgets(self, n):
        for i in range(n):
            list_item = QListWidgetItem(self.list_widget)
            custom_widget = CustomWidget(f"Текст метки {i+1}", f"Кнопка {i+1}")
            # Устанавливаем размер элемента списка для соответствия пользовательскому виджету
            list_item.setSizeHint(custom_widget.sizeHint())
            self.list_widget.setItemWidget(list_item, custom_widget)

app = QApplication(sys.argv)
main_window = MainWindow()
main_window.show()
sys.exit(app.exec())