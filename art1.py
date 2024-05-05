from bitarray import bitarray
from sqlite_adapter import SqliteAdapter

DEBUG = False

class Vector:
    # Конструктор битового вектора
    def __init__(self, array):
        self.vector = bitarray(array)

    # Длина вектора
    def __len__(self):
        return len(self.vector)
    
    # Значимость вектора
    def significance(self):
        return self.vector.count(1)

    # Побитовое "И" двух векторов
    def __and__(self, other) -> "Vector":
        if not isinstance(other, Vector):
            raise ValueError
        
        return Vector(self.vector & other.vector)
        
    def __repr__(self):
        return self.vector.to01()


class Art1:
    def __init__(self):
        # Векторы-прототипы - один вектор соответствует одному кластеру
        self.prototype_vectors: list[Vector] = []

        # Векторы-признаки - каждому вектору соответствует один пользователь. Единицы в векторе - понравившиеся пользователю песни
        self.feature_vectors: list[Vector] = []

        # Вспомогательный объект, помогающий определить к какому кластеру принадлежит вектор признаков
        # если self.clusters[55] = 3, то 55 вектор признаков принадлежит к 3 кластеру 
        self.clusters: dict[int, int] = {}
        
        # Параметр "Разрушения связи"
        self.beta = 1.0

        # Параметр "Внимательность"
        self.rho = 0.8

        # Параметр "Размер веторов" - будет инициализирован позже
        self.vector_size = None

    # Первая стадия алгоритма - создаем кластеры и относим к ним векторы-признаки. Потом принадлоежность будет уточняться.
    def create_clusters(self):
        # Первый кластер создается из первого вектора признаков
        self.create_new_cluster(0, self.feature_vectors[0])

        for feature_vector_index, feature_vector in enumerate(self.feature_vectors[1:], 1):
            for cluster_index, prototype_vector in enumerate(self.prototype_vectors):

                # Флаг о том, что для текущего вектора признаков был найден кластер
                cluster_found = False

                # Проверка на схожесть
                if not self.similarity_test(prototype_vector, feature_vector):
                    # Если не похож - переходим к следующему вектору прототипу
                    if DEBUG: print(f"Вектор {feature_vector_index} не прошел проверку схожести с кластером {cluster_index}")
                    continue

                # Тест на внимательность
                if not self.accuracy_test(prototype_vector, feature_vector):
                    # Если тест на внимательность не пройден - переходим к следующему вектору прототипу
                    if DEBUG: print(f"Вектор {feature_vector_index} не прошел тест на внимательность с кластером {cluster_index}")
                    continue

                # Если обе проверки пройдены - добавляем вектор признаков в кластер:
                if DEBUG: print(f"Вектор {feature_vector_index} добавлен в кластер {cluster_index}")
                self.add_vector_to_cluster(feature_vector_index, feature_vector, cluster_index)
                cluster_found = True

                # Перейти к следующему вектору признаков
                break

            # Если для вектора признаков не подошел ни один кластер
            if not cluster_found:
                # Создаем новый кластер из этого вектора признаков
                if DEBUG: print(f"Вектор {feature_vector_index} не нашел себе кластер")
                self.create_new_cluster(feature_vector_index, feature_vector)


    # Вторая стадия алгоритма: проверяем, есть ли для векторов прототипов более подходящий кластер, чем текущий
    def reorganaze_clusters(self):
        for feature_vector_index, feature_vector in enumerate(self.feature_vectors):
            for prototype_vector_index, prototype_vector in enumerate(self.prototype_vectors):
                raise NotImplementedError
    

    # Создать новый кластер (новый вектор-прототип)
    def create_new_cluster(self, vector_index, vector):
        # Индекс нового вектора-прототипа будет равен количеству существующих векторов-прототипов
        new_cluster_index = len(self.prototype_vectors)

        if DEBUG: print(f"Создаем новый кластер {new_cluster_index}")
        
        # Добавляем новый вектор-прототип
        self.prototype_vectors.append(vector)
        
        # Указываем принадложеность вектора признаков к новому кластеру
        self.clusters[vector_index] = new_cluster_index

    
    # Проверка на схожесть
    def similarity_test(self, p: Vector, e: Vector) -> bool:
        left_side = (p & e).significance() / (self.beta + p.significance())
        right_sige = e.significance() / (self.beta + self.vector_size)

        return left_side > right_sige
    
    
    

    # Тест на внимательность
    def accuracy_test(self, p: Vector, e: Vector) -> bool:
        left_side = (p & e).significance()
        right_side = e.significance()

        return left_side / right_side < self.rho
    
    


    # Добавляем вектор в кластер с изменением вектора-прототипа, соответствующего этому кластеру 
    def add_vector_to_cluster(self, feature_vector_index, feature_vector, cluster_index):
        old_prototype_vector = self.prototype_vectors[cluster_index]

        # Получаем новый вектор-прототип для кластера с помощью побитового И
        new_prototype_vector = old_prototype_vector & feature_vector
        self.prototype_vectors[cluster_index] = new_prototype_vector

        # Указываем принадлоежность вектора признаков к кластеру:
        self.clusters[feature_vector_index] = cluster_index

    # Инициализируем алгоритм данными - передаем ему векторы-признаки
    def initialize_data(self):
        for vector in SqliteAdapter().like_vectors():
            self.feature_vectors.append(Vector(vector))

        # Инициализация параметра "Размер векторов"
        self.vector_size = len(self.feature_vectors[0])
    
        # -1 означает что вектор признаков пока не принадлежит ни к одному из кластеров
        for i in range(self.vector_size):
            self.clusters[i] = -1

    # Выводит информацию о состоянии алгоритма
    def __repr__(self):
        info = "ART1 algorythm state:\n"
        for cluster_index, cluster in enumerate(self.prototype_vectors):
            info += f"Cluster {cluster_index}:\n"
            info += str(cluster) + "\n"
            info += "Members:\n"
            for feature_vector_index, feature_vecor in enumerate(self.feature_vectors):
                if self.clusters[feature_vector_index] == cluster_index:
                    info += f"{feature_vecor} - #{feature_vector_index}, s: {self._similarity(cluster, feature_vecor)}, a: {self._accuracy(cluster, feature_vecor)}\n"
            info += "=" * self.vector_size + "\n"
        info += "\n"
        return info

    def _similarity(self, p: Vector, e: Vector) -> bool:
            left_side = (p & e).significance() / (self.beta + p.significance())
            right_sige = e.significance() / (self.beta + self.vector_size)

            return round(left_side, 2), round(right_sige, 2)

    def _accuracy(self, p: Vector, e: Vector) -> bool:
            left_side = (p & e).significance()
            right_side = e.significance()

            return round(left_side / right_side, 3)
