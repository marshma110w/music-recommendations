from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel, QStackedLayout,
                             QListWidgetItem, QHBoxLayout, QGroupBox, QCheckBox
                            )
from PyQt6.QtCore import Qt, QSize
from PyQt6.QtGui import QIcon, QPixmap
from sqlite_adapter import SqliteAdapter
from recommendator import Recommendator

from widgets.track_widget import TrackWidget
from widgets.genre_widget import GenreWidget
from widgets.artist_widget import ArtistWidget
from widgets.welcome_song_widget import WelcomeSongWidget

class MiniPlayerUI(QMainWindow):
    def __init__(self, user_id, resolver):
        super().__init__()
        self.setStyleSheet("background-color: darkkhaki; color: black")
        self.db = SqliteAdapter()
        user_name = self.db.login_by_id(user_id)

        self.setWindowTitle("Мини-Плеер [{}]".format(user_name))

        self.resolver = resolver
        self.user_id = user_id
        self.resize(800, 800)

        # Инициализация страниц
        library_page = self.library_page_init()
        rec_page = self.recommendation_page_init()

        # Основной слой, где будут размещены страницы приложения
        self.layout = QStackedLayout()
        self.layout.addWidget(library_page)
        self.layout.addWidget(rec_page)  # Добавить страницу в стек

        self.set_page(0)

        # Установить виджет с основным макетом в качестве центрального виджета
        self.central_widget = QWidget()
        self.central_widget.setLayout(self.layout)
        self.setCentralWidget(self.central_widget)


    def library_page_init(self):
        self.library_page = QWidget()  # Создаем вторую страницу для библиотеки
        self.library_layout = QVBoxLayout()

        self.settings_layout = QHBoxLayout()
        self.settings_button = QPushButton()
        self.settings_button.setIcon(QIcon("gears_icon.png"))
        self.settings_button.setIconSize(QSize(50, 50))
        self.settings_button.setStyleSheet("border-style: none")

        self.settings_layout.addStretch()
        self.settings_layout.addWidget(self.settings_button)

        # Создаем список песен
        self.library_songs_list = QListWidget()

        # Кнопка для перехода на первую страницу
        self.switch_to_recommendations_button = QPushButton("Перейти на страницу рекомендаций")
        self.switch_to_recommendations_button.setStyleSheet("background-color: darkorange")
        self.switch_to_recommendations_button.clicked.connect(self.switch_page)
        self.settings_button.clicked.connect(self.to_settings_page)

        # Добавляем элементы на макет страницы библиотеки
        self.library_layout.addLayout(self.settings_layout)
        self.library_layout.addWidget(self.library_songs_list)
        self.library_layout.addWidget(self.switch_to_recommendations_button)
        self.library_page.setLayout(self.library_layout)
        self.populate_library(self.user_id)

        return self.library_page

    def recommendation_page_init(self):
        self.recommendations_layout = QVBoxLayout()

        self.create_playlist_button = QPushButton("Моя волна ♬")
        self.create_playlist_button.setStyleSheet("background-color: darkorange; border-radius: 50px; border-style: solid; border-width: 5px")
        self.create_playlist_button.setFixedSize(100, 100)
        self.create_playlist_button.clicked.connect(self.create_playlist)

         # Список песен
        self.songs_list = QListWidget()
        # self.songs_list.setVisible(False)  # Список песен изначально невидим
        # self.songs_list.setFixedHeight(TrackWidget('', '', '', 1, 1, 1, True, []).sizeHint().height() * 7)
        self.songs_list.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)

        # Выбор настроения
        moods = self.db.moods()
        self.mood_layout = QVBoxLayout()
        self.mood_group = QGroupBox()
        self.mood_buttons = [QCheckBox(mood) for mood in moods]
        for button in self.mood_buttons:
            self.mood_layout.addWidget(button)
        self.mood_group.setLayout(self.mood_layout)
        self.mood_group.setTitle("Настроение")
        

        # Кнопка для перехода на вторую страницу
        self.switch_page_button = QPushButton("Перейти на страницу библиотеки")
        self.switch_page_button.setStyleSheet("background-color: darkorange")
        self.switch_page_button.clicked.connect(self.switch_page)


        self.recommendations_layout.addWidget(self.create_playlist_button, 0, Qt.AlignmentFlag.AlignHCenter)  # Выравнивание по центру

        self.recommendations_layout.addWidget(self.mood_group)

        # self.recommendations_layout.addStretch()  # Добавить растяжитель
        self.recommendations_layout.addWidget(self.songs_list)
        self.recommendations_layout.addWidget(self.switch_page_button)


        # Создать виджет для страницы рекомендаций и установить его макет
        self.recommendations_page = QWidget()
        self.recommendations_page.setLayout(self.recommendations_layout)

        return self.recommendations_page


    def create_playlist(self):
        moods = self.get_mood()
        recommendator = Recommendator()
        rec_ids = recommendator.make_recommendation(self.user_id, 10, moods)
        songs = self.db.tracks_by_ids_for_user(rec_ids, self.user_id)
        self.songs_list.clear()
        for song in songs:
            list_item = QListWidgetItem(self.songs_list)
            track = TrackWidget(song[0], song[1], song[2], song[4], song[3], self.user_id, song[5], ["play", "like"])
            list_item.setSizeHint(track.sizeHint())
            self.songs_list.setItemWidget(list_item, track)

        self.songs_list.setVisible(True)


    def switch_page(self):
        current_index = self.layout.currentIndex()
        new_index = 1 if current_index == 0 else 0  # Вычисляем индекс новой страницы
        self.set_page(new_index)  # Устанавливаем новую страницу активной


    def to_settings_page(self):
        self.resolver.activate_settings(self.user_id)


    def to_library(self):
        self.selected_songs = []
        for item in self.welcome_songs_list.findItems('', Qt.MatchFlag.MatchContains):
            song = self.welcome_songs_list.itemWidget(item)
            if song.checked():
                self.selected_songs.append(song.id)
        
        if self.selected_songs:
            self.db.clear_liked_songs(self.user_id)
            self.db.like_songs(self.user_id, self.selected_songs)
            self.populate_library(self.user_id)
            self.set_page(3)


    def populate_library(self, login):
        self.library_songs_list.clear()
        records = self.db.get_library(login)
        for record in records:
            list_item = QListWidgetItem(self.library_songs_list)
            track = TrackWidget(record[0], record[1], record[2], record[4], record[3], self.user_id, True, ["like", "play"])
            list_item.setSizeHint(track.sizeHint())

            self.library_songs_list.setItemWidget(list_item, track)


    def get_mood(self):
        return [button.text() for button in self.mood_buttons if button.isChecked()]


    def set_page(self, index):
        if index == 3:
            self.populate_library(self.user_id)

        self.layout.setCurrentIndex(index)
