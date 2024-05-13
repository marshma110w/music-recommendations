from bitarray import bitarray
from sqlite_adapter import SqliteAdapter
from collections import defaultdict

DEBUG = True

# Если отладочный вывод включен, очищаем лог-файл
if DEBUG:
    log_file = open("art1.log", "wt")
    log_file.close()


# Пишем в лог-файл переданную строку, если дебаг включен
def debug_print(text):
    if DEBUG:
        with open("art1.log", "at") as log_file:
            log_file.write(f"DEBUG: {text}\n")


# Класс, описывающий один вектор
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
    

# Класс, хранящий информацию о том, какие векторы к какми кластерам принадлежат
class ClusterMapper:
    def __init__(self):

        # Словарь, который знает, какие элементы лежат в кластере
        self.cluster_elements: dict[int, set[int]] = defaultdict(set)

        # Словарь, который знает, какому кластеру принадлежит элемент
        self.element_cluster: dict[int, int] = defaultdict(lambda: -1)

    # Добавить элемент в кластер
    def add_element_to_cluster(self, new_cluster, element):
        old_cluster = self.element_cluster[element]
        
        # Если элемент уже принадлежал какому-то кластеру, удаляем его оттуда
        if old_cluster != -1:
            self.cluster_elements[old_cluster].remove(element)
        
        # Относим элемент к новому кластеру
        self.cluster_elements[new_cluster].add(element)
        self.element_cluster[element] = new_cluster


    # Метод чтобы узнать в каком кластере элемент
    def get_cluster_by_element(self, element):
        return self.element_cluster[element]

    
    # Метод чтобы узнать какие элементы есть в кластере
    def get_elements_by_cluster(self, cluster):
        return self.cluster_elements[cluster]


class Art1:
    def __init__(self):
        # Векторы-прототипы - один вектор соответствует одному кластеру
        self.prototype_vectors: list[Vector] = []

        # Векторы-признаки - каждому вектору соответствует один пользователь. Единицы в векторе - понравившиеся пользователю песни
        self.feature_vectors: list[Vector] = []

        # Вспомогательный объект, помогающий определить к какому кластеру принадлежит вектор признаков
        self.cluster_mapper = ClusterMapper()
        
        # Параметр "Разрушения связи"
        self.beta = 1.0

        # Параметр "Внимательность"
        self.rho = 0.8

        # Параметр "Размер веторов" - будет инициализирован позже
        self.vector_size = None

        # Параметр "Максимальное количество итераций"
        self.max_iterations_count = 50

        # Флаг завершения алгоритма
        # Алгоритм завершен если за итерацию не обновился ни один вектор-прототип или если достигнуто максимальное число итераций
        self.done = False


    def run(self):
        count = 0
        
        # Выходим из цикла если выставился флаг done либо превышено максимальное число итераций
        while not self.done and count < self.max_iterations_count:
            self.run_iteration()
            count += 1 
            debug_print(f"Итерация {count} завершилась")
            debug_print(self)
        debug_print("Алгоритм завершился")


    def run_iteration(self):
        """
            Одна итерация алгоритма - проходим по всем векторам-признакам и по всем векторам-прототипам,
            проверяем схожесть и при необходимости обновляем векторы-прототипы и принадлежность ыекторов-признакоов кластерам
        """

        # Флаг изменится на False если в ходе итерации обновится или создастся кластер
        self.done = True

        for feature_vector_index, feature_vector in enumerate(self.feature_vectors):
            for cluster_index, prototype_vector in enumerate(self.prototype_vectors):

                # Если вектор признаков уже принадлежит проверяемому кластеру, нет смысла его добавлять в него же
                if self.cluster_mapper.get_cluster_by_element(feature_vector_index) == cluster_index:
                    debug_print(f"Вектор {feature_vector_index} уже находится в кластере {cluster_index}")
                    continue

                # Проверка на схожесть
                if not self.similarity_test(prototype_vector, feature_vector):
                    # Если не похож - переходим к следующему вектору прототипу
                    debug_print(f"Вектор {feature_vector_index} не прошел проверку схожести с кластером {cluster_index}")
                    continue

                # Тест на внимательность
                if not self.accuracy_test(prototype_vector, feature_vector):
                    # Если тест на внимательность не пройден - переходим к следующему вектору прототипу
                    debug_print(f"Вектор {feature_vector_index} не прошел тест на внимательность с кластером {cluster_index}")
                    continue

                # Если обе проверки пройдены - добавляем вектор признаков в кластер:
                debug_print(f"Вектор {feature_vector_index} добавлен в кластер {cluster_index}")
                self.add_vector_to_cluster(feature_vector_index, feature_vector, cluster_index)

            # Если вектор призноаков не принадлежит ни одному кластеру
            if self.cluster_mapper.get_cluster_by_element(feature_vector_index) == -1:
                # Создаем новый кластер из этого вектора признаков
                debug_print(f"Вектор {feature_vector_index} не нашел себе кластер")
                self.create_new_cluster(feature_vector_index, feature_vector)
    

    # Создать новый кластер (новый вектор-прототип)
    def create_new_cluster(self, vector_index, vector):
        # Индекс нового вектора-прототипа будет равен количеству существующих векторов-прототипов
        new_cluster_index = len(self.prototype_vectors)

        debug_print(f"Создаем новый кластер {new_cluster_index}")
        
        # Добавляем новый вектор-прототип
        self.prototype_vectors.append(vector)
        
        # Указываем принадложеность вектора признаков к новому кластеру
        self.cluster_mapper.add_element_to_cluster(new_cluster_index, vector_index)

        # Так как был создан новый вектор-прототип, алгоритм не должен завершаться на этой итерации
        self.done = False

    
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
    def add_vector_to_cluster(self, feature_vector_index, feature_vector, dest_cluster_index):
        # Получаем индекс старого кластера
        source_cluster_index = self.cluster_mapper.get_cluster_by_element(feature_vector_index)
        
        old_prototype_vector = self.prototype_vectors[dest_cluster_index]

        # Получаем новый вектор-прототип для кластера с помощью побитового И
        new_prototype_vector = old_prototype_vector & feature_vector
        self.prototype_vectors[dest_cluster_index] = new_prototype_vector

        # Указываем принадлоежность вектора признаков к кластеру:
        self.cluster_mapper.add_element_to_cluster(dest_cluster_index, feature_vector_index)

        if source_cluster_index != -1:
            # Если старый кластер был, надо его пересчитать, так как из него ушел один элемент
            self.recalculate_cluster(source_cluster_index)

        # Так как кластер был обновлен, алгоритм не должен завершаться на текущей итерации
        self.done = False

    
    # Пересчитываем вектор-прототип для указанного кластера:
    def recalculate_cluster(self, cluster_index):
        debug_print(f"Пересчитываем кластер {cluster_index}")
        cluster_vectors = self.cluster_mapper.get_elements_by_cluster(cluster_index)
        
        # Побитовое "И" всех векторов в кластере:
        and_vector = Vector([1 for _ in range(self.vector_size)])
        for vector_index in cluster_vectors:
            and_vector = and_vector & self.feature_vectors[vector_index]

        self.prototype_vectors[cluster_index] = and_vector

    # Инициализируем алгоритм данными - передаем ему векторы-признаки
    def initialize_data(self):
        for vector in SqliteAdapter().like_vectors():
            self.feature_vectors.append(Vector(vector))

        # Инициализация параметра "Размер векторов"
        self.vector_size = len(self.feature_vectors[0])


    # Выводит информацию о состоянии алгоритма
    def __repr__(self):
        info = "ART1 algorythm state:\n"
        for cluster_index, cluster in enumerate(self.prototype_vectors):
            info += f"Cluster {cluster_index}:\n"
            info += str(cluster) + "\n"
            info += "Members:\n"
            for feature_vector_index, feature_vecor in enumerate(self.feature_vectors):
                if self.cluster_mapper.get_cluster_by_element(feature_vector_index) == cluster_index:
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
