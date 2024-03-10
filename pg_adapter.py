import psycopg2

class PGAdapter:
    _instance = None

    def new(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(PGAdapter, cls).new(cls, *args, **kwargs)
        return cls._instance
    
    def __init__(self):
        self.connection = psycopg2.connect(
            database = 'music',
            user = 'music',
            password = 'music',
            host = '127.0.0.1',
            port = '5432'
        )

    def query(self, q):
        print(q)
        cursor = self.connection.cursor()
        cursor.execute(q)
        if 'SELECT' in q:
            records = cursor.fetchall()
        else:
            records = []
        self.connection.commit()
        cursor.close()
        return records
    
    def get_library(self, user_id):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
                JOIN users_tracks_likes l ON l.track_id = t.id
                JOIN users u ON l.user_id = u.id
                WHERE u.id = '{}'
        """.format(user_id))
    
    def songs_count(self):
        return self.query("""
            SELECT COUNT(*) FROM tracks           
        """)[0][0]
    
    def users_count(self):
        return self.query("""
            SELECT COUNT(*) FROM users
        """)[0][0]
    
    def like_vectors(self):
        lib = [[0 for i in range(self.songs_count())] for j in range(self.users_count())]
        result = self.query("""
            SELECT user_id, track_id
            FROM users_tracks_likes
        """)
        for record in result:
            lib[record[0]-1][record[1]-1] = 1
        return lib
    
    def tracks_by_ids(self, ids):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
            WHERE t.id IN {}
        """.format(tuple(ids)))

    def genres(self):
        return self.query("""
            SELECT name, id FROM genres                  
        """)

    def like_songs(self, user_id, songs_ids):
        pairs = []
        for song_id in songs_ids:
            pairs.append('({}, {})'.format(user_id, song_id))
        return self.query("""
            INSERT INTO users_tracks_likes (user_id, track_id) VALUES
            {}
        """.format(',\n'.join(pairs)))
    
    def artists_by_genres(self, genres_ids):
        return self.query("""
            SELECT a.name, g.name, a.id
            FROM artists a JOIN genres g ON a.genre_id = g.id
            WHERE g.id IN {}
        """.format(self._sql_seq(genres_ids)))
    
    def tracks_by_artists(self, artists_ids):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
                WHERE a.id in {}
        """.format(self._sql_seq(artists_ids)))
    
    def users(self):
        return self.query("""
            SELECT login, id
            FROM users
        """)
    
    def create_user(self, login, password):
        self.query("""
            INSERT INTO users (login, password) VALUES ('{}', '{}')
        """.format(login, password))

        id = self.query("""
            SELECT id FROM users
            WHERE login = '{}'                
        """.format(login))
        return id[0][0]
    
    def user_exists(self, login):
        result = self.query("""
            SELECT 1 FROM users WHERE login = '{}'
        """.format(login))
        return bool(result)
    
    def authenticate(self, login, password):
        result = self.query("""
            SELECT 1 FROM users WHERE login = '{}' AND password = '{}'                    
        """.format(login, password))
        return bool(result)
    
    def id_by_login(self, login):
        result = self.query("""
            SELECT id FROM users WHERE login = '{}'                    
        """.format(login))
        return result[0][0]
    
    def login_by_id(self, id):
        result = self.query("""
            SELECT login FROM users WHERE id = {}                    
        """.format(id))
        return result[0][0]
    
    def _sql_seq(self, iterable):
        return "({})".format(', '.join(map(str, iterable)))
