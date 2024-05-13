from art1 import Art1
from sqlite_adapter import SqliteAdapter


class Recommendator:
    """
    Класс, использующий результат работы алгоритма ART1 для формирования рекомендаций
    """
    def __init__(self):
        self.art1 = Art1()
        self.db = SqliteAdapter()

        self.art1.initialize_data()
        self.art1.run()


    def make_recommendation(self, user_id, amount, moods = []):
        neighbours = self.cluster_neighbours(user_id)
        sum_vector = self.sum_vector(neighbours)
        sum_vector = list(enumerate(sum_vector))

        sum_vector = [(self.db_id(id), value) for id, value in sum_vector]

        #  Оставляем только песнии в нужном настроении
        if moods:
            mood_tracks_ids = self.db.ids_by_moods(moods)
            sum_vector = list(filter(lambda pair: pair[0] in mood_tracks_ids, sum_vector))

        #  Оставляем только те песни которых нет в библиотеке пользователя
        user_library_ids = self.db.library_ids(user_id)
        sum_vector = list(filter(lambda pair: pair[0] not in user_library_ids, sum_vector))

        #  Сортируем по убыванию суммы
        sum_vector.sort(key=lambda record: record[1], reverse=True)

        #  Берем N первых
        sum_vector = sum_vector[:amount]

        #  Возвращаем только id
        return [pair[0] for pair in sum_vector]


    #  Метод, возвращающий все векторы признаков, являющиеся "соседями" по кластеру для переданного id пользователя
    def cluster_neighbours(self, user_id):
        #  Преобразуем id пользователя в БД в id пользователя в алгоритме ART1
        art1_user_id = self.art1_id(user_id)

        #  Вектор признаков, соответствующий пользователю
        user_feature_vector = self.art1.feature_vectors[art1_user_id]

        #  id кластера, в котором находится пользователь
        cluster_id = self.art1.cluster_mapper.element_cluster[art1_user_id]

        #  Все векторы признаков в кластере
        cluster_feature_vectors_ids = self.art1.cluster_mapper.cluster_elements[cluster_id]
        cluster_feature_vectors = [self.art1.feature_vectors[id] for id in cluster_feature_vectors_ids]
        
        #  Убираем из всех векторов признаков вектор, соответствующий пользователю
        cluster_feature_vectors.remove(user_feature_vector)

        return cluster_feature_vectors 


    #  Вычисляет вектор суммирования нескольких векторов
    def sum_vector(self, vectors):
        length = len(vectors[0])
        result = [0 for _ in range(length)]
        for vector in vectors:
            result = [x + y for x, y in zip(result, vector.vector.tolist())]

        return result


    def art1_id(self, user_id):
        return user_id - 1


    def db_id(self, id):
        return id + 1
