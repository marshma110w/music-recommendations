from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QPushButton, QListWidget, QLabel, QStackedLayout,
                             QListWidgetItem, QHBoxLayout, QGroupBox, QCheckBox
                            )
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QIcon, QPixmap
from pg_adapter import PGAdapter
from recommendation import Recommendation

from widgets.track_widget import TrackWidget
from widgets.genre_widget import GenreWidget
from widgets.artist_widget import ArtistWidget
from widgets.welcome_song_widget import WelcomeSongWidget


class MiniPlayerUI(QMainWindow):
    def __init__(self, user_id):
        super().__init__()

        self.db = PGAdapter()
        user_name = self.db.login_by_id(user_id)

        self.setWindowTitle("Мини-Плеер [{}]".format(user_name))
        self.user_id = user_id
        self.user_name = user_name
        self.resize(800, 800)

        # Инициализация страниц
        library_page = self.library_page_init()
        rec_page = self.recommendation_page_init()
        genres_page = self.genre_selection_page_init()
        artists_page = self.artist_selection_page_init()
        welcome_songs_page = self.welcome_songs_selection_page_init()


        # Основной слой, где будут размещены страницы приложения
        self.layout = QStackedLayout()
        self.layout.addWidget(genres_page)
        self.layout.addWidget(artists_page)
        self.layout.addWidget(welcome_songs_page)
        self.layout.addWidget(library_page)
        self.layout.addWidget(rec_page)  # Добавить страницу в стек
        

        if self.db.get_library(self.user_id):
            self.set_page(3)
        else:
            self.set_page(0)


        # Установить виджет с основным макетом в качестве центрального виджета
        self.central_widget = QWidget()
        self.central_widget.setLayout(self.layout)
        self.setCentralWidget(self.central_widget)

    def library_page_init(self):
        self.library_page = QWidget()  # Создаем вторую страницу для библиотеки
        self.library_layout = QVBoxLayout()

        # Создаем список песен
        self.library_songs_list = QListWidget()

        # Кнопка для перехода на первую страницу
        self.switch_to_recommendations_button = QPushButton("Перейти на страницу рекомендаций")
        self.switch_to_recommendations_button.clicked.connect(self.switch_page)

        # Добавляем элементы на макет страницы библиотеки
        self.library_layout.addWidget(self.library_songs_list)
        self.library_layout.addWidget(self.switch_to_recommendations_button)
        self.library_page.setLayout(self.library_layout)
        self.populate_library(self.user_id)

        return self.library_page

    def recommendation_page_init(self):
        self.recommendations_layout = QVBoxLayout()

        self.create_playlist_button = QPushButton("")
        self.create_playlist_button.setStyleSheet("QPushButton {"
                                                  "  border-radius: 50px;"
                                                  "  background-color: #89CFF0;"
                                                  "  border-style: solid;"
                                                  "}")
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
    
    def genre_selection_page_init(self):
        self.genre_selection_layout = QVBoxLayout()
        self.genre_selection_title = QLabel("Выберете любимые жанры:")
        self.genres_list = QListWidget()
        self.genres_submit_button = QPushButton('К артистам')
        self.genres_submit_button.clicked.connect(self.to_artists_page)
        self.fill_genres()

        self.genre_selection_layout.addWidget(self.genre_selection_title)
        self.genre_selection_layout.addWidget(self.genres_list)
        self.genre_selection_layout.addWidget(self.genres_submit_button)
        self.genre_selection_page = QWidget()
        self.genre_selection_page.setLayout(self.genre_selection_layout)

        return self.genre_selection_page
    
    def artist_selection_page_init(self):
        self.artist_selection_layout = QVBoxLayout()
        self.artist_selection_title = QLabel("Выберете любимых артистов:")
        self.artist_selection_back_button = self.back_button()
        self.artist_selection_title_layout = QHBoxLayout()
        self.artists_list = QListWidget()
        self.artists_submit_button = QPushButton('К песням')
        self.artists_submit_button.clicked.connect(self.to_songs_page)

        self.artist_selection_title_layout.addWidget(self.artist_selection_title)
        self.artist_selection_title_layout.addStretch()
        self.artist_selection_title_layout.addWidget(self.artist_selection_back_button)
        self.artist_selection_layout.addLayout(self.artist_selection_title_layout)
        self.artist_selection_layout.addWidget(self.artists_list)
        self.artist_selection_layout.addWidget(self.artists_submit_button)
        self.artist_selection_page = QWidget()
        self.artist_selection_page.setLayout(self.artist_selection_layout)
        self.artists_list.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)

        return self.artist_selection_page
    
    def welcome_songs_selection_page_init(self):
        self.welcome_songs_selection_layout = QVBoxLayout()
        self.welcome_songs_selection_title = QLabel("Выберете любимые треки:")
        self.welcome_songs_selection_back_button = self.back_button()
        self.welcome_songs_list = QListWidget()
        self.welcome_songs_submit_button = QPushButton("Добавить")
        self.welcome_songs_submit_button.clicked.connect(self.to_library)

        self.welcome_songs_selection_title_layout = QHBoxLayout()
        self.welcome_songs_selection_title_layout.addWidget(self.welcome_songs_selection_title)
        self.welcome_songs_selection_title_layout.addStretch()
        self.welcome_songs_selection_title_layout.addWidget(self.welcome_songs_selection_back_button)
    
        self.welcome_songs_selection_layout.addLayout(self.welcome_songs_selection_title_layout)
        self.welcome_songs_selection_layout.addWidget(self.welcome_songs_list)
        self.welcome_songs_selection_layout.addWidget(self.welcome_songs_submit_button)
        self.welcome_songs_selection_page = QWidget()
        self.welcome_songs_selection_page.setLayout(self.welcome_songs_selection_layout)
        self.welcome_songs_list.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)

        return self.welcome_songs_selection_page


    def fill_genres(self):
        genres = self.db.genres()
        for record in genres:
            list_item = QListWidgetItem(self.genres_list)
            genre = GenreWidget(record[0], record[1])
            list_item.setSizeHint(genre.sizeHint())
            self.genres_list.setItemWidget(list_item, genre)


    def fill_artists(self, genres_ids):
        artists = self.db.artists_by_genres(genres_ids)
        for record in artists:
            list_item = QListWidgetItem(self.artists_list)
            artist = ArtistWidget(record[0], record[1], record[2])
            list_item.setSizeHint(artist.sizeHint())
            self.artists_list.setItemWidget(list_item, artist)

    def fill_songs_to_select(self, artists_ids):
        songs = self.db.tracks_by_artists(artists_ids)
        for record in songs:
            list_item = QListWidgetItem(self.welcome_songs_list)
            song = WelcomeSongWidget(record[0], record[1], record[2], record[3], record[4])
            list_item.setSizeHint(song.sizeHint())
            self.welcome_songs_list.setItemWidget(list_item, song)


    def make_icon(self, image_path):
        # Создание иконки для кнопки из изображения
        pixmap = QPixmap(image_path)
        return QIcon(pixmap.scaled(80, 80, Qt.AspectRatioMode.KeepAspectRatio, Qt.TransformationMode.SmoothTransformation))


    def create_playlist(self):
        # Обработчик для кнопки создания плейлиста
        # Определите здесь логику создания плейлиста и добавления элементов в список
        moods = self.get_mood()
        recommendator = Recommendation(moods)
        rec_ids = recommendator.recommend_playlist(self.user_id - 1, 7)
        songs = self.db.tracks_by_ids_for_user(rec_ids, self.user_id)
        self.songs_list.clear()
        for song in songs:
            list_item = QListWidgetItem(self.songs_list)
            track = TrackWidget(song[0], song[1], song[2], song[4], song[3], self.user_id, song[5], ["play", "like"])
            list_item.setSizeHint(track.sizeHint())
            self.songs_list.setItemWidget(list_item, track)

        self.songs_list.setVisible(True)
        # Добавляем тестовые песни в список
        # self.songs_list.addItems(["Песня 1", "Песня 2", "Песня 3"])  # Заглушки для примера


    def switch_page(self):
        current_index = self.layout.currentIndex()
        new_index = 3 if current_index == 4 else 4  # Вычисляем индекс новой страницы
        self.set_page(new_index)  # Устанавливаем новую страницу активной


    def to_artists_page(self):
        self.selected_genres = []
        for item in self.genres_list.findItems('', Qt.MatchFlag.MatchContains):
            genre = self.genres_list.itemWidget(item)
            if genre.checked():
                self.selected_genres.append(genre.id)

        if self.selected_genres:
            self.fill_artists(self.selected_genres)
            # self.db.clear_liked_genres(self.user_id)
            # like genres
            self.set_page(1)

    def to_songs_page(self):
        self.selected_artists = []
        for item in self.artists_list.findItems('', Qt.MatchFlag.MatchContains):
            artist = self.artists_list.itemWidget(item)
            if artist.checked():
                self.selected_artists.append(artist.id)

        if self.selected_artists:
            self.fill_songs_to_select(self.selected_artists)
            self.db.clear_liked_artists(self.user_id)
            # like artists
            self.set_page(2)

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


    def remove_song(self, title):
        # Находим элементы в списке, сопоставляемые с названием и удаляем их
        items = self.library_songs_list.findItems(title, Qt.MatchFlag.MatchExactly)
        if not items:
            return
        for item in items:
            row = self.library_songs_list.row(item)
            self.library_songs_list.takeItem(row)

    def populate_library(self, login):
        self.library_songs_list.clear()
        records = self.db.get_library(login)
        for record in records:
            list_item = QListWidgetItem(self.library_songs_list)
            track = TrackWidget(record[0], record[1], record[2], record[4], record[3], self.user_id, True, ["like", "play"])
            list_item.setSizeHint(track.sizeHint())

            self.library_songs_list.setItemWidget(list_item, track)

    def back_button(self):
        back_button = QPushButton("Назад")
        back_button.clicked.connect(self.back_page)
        return back_button

    def back_page(self):
        cur_index = self.layout.currentIndex()
        self.layout.setCurrentIndex(cur_index - 1)

    def get_mood(self):
        return [button.text() for button in self.mood_buttons if button.isChecked()]

    def set_page(self, index):
        if index == 3:
            self.populate_library(self.user_id)

        self.layout.setCurrentIndex(index)