from pg_adapter import PGAdapter
from random import randint


class Recommendation:

    def __init__(self, moods=[]):
        self.db = PGAdapter()

        self.moods = moods

        self.MAX_CLUSTERS = 5

        self.SONGS_COUNT = self.db.songs_count()
        self.USERS_COUNT = self.db.users_count()

        self.beta = 1.0
        self.vigilance = 0.9  # Внимательность

        self.prototype_vectors_count = 0

        self.prototype_vectors = [[0 for i in range(self.SONGS_COUNT)] for _ in range(self.MAX_CLUSTERS)]

        # Вектор суммирования
        self.sum_vector = [[0 for i in range(self.SONGS_COUNT)] for j in range(self.MAX_CLUSTERS)]

        # Количество членов в кластерах
        self.cluster_population = [0 for i in range(self.USERS_COUNT)]

        # Номер кластера, к которому принадлежит покупатель
        self.cluster_by_user = [-1 for i in range(self.USERS_COUNT)]

        # Все песни
        self.song_ids = []

        self.database = self.db.like_vectors()

    
    def perform(self):
        andresult = [0 for i in range(self.SONGS_COUNT)]
        done = False
        count = 50

        while not done:
            done = True

            # По всем покупателям
            for index in range(self.USERS_COUNT):
                for pvec in range(self.MAX_CLUSTERS):
                    if self.cluster_population[pvec]:
                        andresult = self._bitwise_and(self.prototype_vectors[pvec], self.database[index])
                        
                        magPE = self._magnitude(andresult)
                        magP = self._magnitude(self.prototype_vectors[pvec])
                        magE = self._magnitude(self.database[index])

                        result = magPE / (self.beta + magP)

                        test = magE / (self.beta + self.SONGS_COUNT)

                        if result > test:
                            if magPE / magE < self.vigilance:

                                # Убедиться, что это другой кластер
                                if self.cluster_by_user[index] != pvec:
                                    
                                    # Переместить покупателя в другой кластер
                                    old = self.cluster_by_user[index]
                                    self.cluster_by_user[index] = pvec

                                    if old >= 0:
                                        self.cluster_population[old] -= 1
                                        if self.cluster_population[old] == 0:
                                            self.prototype_vectors_count -= 1
                                    self.cluster_population[pvec] += 1

                                    # Пересчитать векторыпрототипы для всех кластеров
                                    if old >= 0 and old < self.MAX_CLUSTERS:
                                        self._update_prototype_vectors(old)
                                    self._update_prototype_vectors(pvec)

                                    done = False
                                    break
                                else:
                                    # Уже в этом кластере
                                    pass
            
                # Проверяем, обработан ли вектор
                if self.cluster_by_user[index] == -1:
                    # Не был найден подходящий кластер – создаем новый кластер для этого вектора признаков
                    self.cluster_by_user[index] = self._create_new_prototype_vector(self.database[index])
                    done = False
        
            count -= 1
            if count < 0:
                break
        return 0
    
    #  Construct playlist of recommendated songs
    def recommend_playlist(self, customer, count):
        user_id = customer + 1
        res = []
        while len(res) < count:
            song = self.make_reccomendation(customer)
            self.database[customer][song] = 1
            song_id = song + 1

            # Skip if song already in recommendation playlist
            if song_id in res:
                continue

            # Skip if mood is wrong
            if self.moods and self.db.mood_by_id(song_id) not in self.moods:
                continue
            
            # Skip if song is already liked
            if self.db.is_liked(song_id, user_id):
                continue

            res.append(song_id)
        return res

    def make_reccomendation(self, customer):
        best_song = -1
        val = 0

        for song in range(self.SONGS_COUNT):
            if self.database[customer][song] == 0 and self.sum_vector[self.cluster_by_user[customer]][song] > val:
                best_song = song
                val = self.sum_vector[self.cluster_by_user[customer]][song]
        
        print("For customer", customer)

        if best_song >= 0:
            print("The best recommendation is {}\n".format(best_song))
            print("Owned by {} out of {} members of this cluster\n".format(self.sum_vector[self.cluster_by_user[customer]][best_song], self.cluster_population[self.cluster_by_user[customer]]))
            return best_song
        else:
            print("No recommendation")
            return randint(0, self.SONGS_COUNT-1) # TODO: return random unliked song

    
    def _magnitude(self, vector):
        return sum(vector)

    
    def _bitwise_and(self, v1, v2):
        l = len(v1)
        result = [0 for _ in range(l)]
        for i in range(l):
            result[i] = v1[i] & v2[i]
        
        return result

    def _create_new_prototype_vector(self, example):
        cluster = self.cluster_population.index(0)
        print('Creating new cluster {}'.format(cluster))

        self.prototype_vectors_count += 1

        for i in range(self.SONGS_COUNT):
            self.prototype_vectors[cluster][i] = example[i]
        
        self.cluster_population[cluster] = 1
        return cluster
    

    def _update_prototype_vectors(self, cluster):
        first = True
        
        for i in range(self.SONGS_COUNT):
            self.prototype_vectors[cluster][i] = 0
            self.sum_vector[cluster][i] = 0

        for customer in range(self.USERS_COUNT):
            if self.cluster_by_user[customer] == cluster:
                if first:
                    for song in range(self.SONGS_COUNT):
                        self.prototype_vectors[cluster][song] = self.database[customer][song]
                        self.sum_vector[cluster][song] = self.database[customer][song]
                    first = False

                else:
                    for song in range(self.SONGS_COUNT):
                        self.prototype_vectors[cluster][song] &= self.database[customer][song]
                        self.sum_vector[cluster][song] += self.database[customer][song]


    


