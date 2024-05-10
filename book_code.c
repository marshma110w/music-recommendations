// Для примера
// Скопированный код из книги

int MAX_ITEMS = 1;
int MAX_CUSTOMERS = 1;
int TOTAL_PROTOTYPE_VECTORS = 1;

int members[];

int membership[];
int vigilance = 0;
int beta = 0;
int numPrototypeVectors = 0;
int ** database;
int ** prototypeVector;

int performART1(void)
{
    int andresult[MAX_ITEMS];
    int prototype_index, magPE, magP, magE;
    float result, test;
    int feature_index, done = 0;
    int count = 50;
    while (!done)
    {
        done = 1;
        /* По всем покупателям */
        for (feature_index = 0; feature_index < MAX_CUSTOMERS; feature_index++)
        {
            /* Шаг 3 */
            for (prototype_index = 0; prototype_index < TOTAL_PROTOTYPE_VECTORS; prototype_index++)
            {
                /* Есть ли в этом кластере элементы? */
                if (members[prototype_index])
                {
                    vectorBitwiseAnd(andresult, &database[feature_index][0],
                                     &prototypeVector[prototype_index][0]);
                    magPE = vectorMagnitude(andresult);
                    magP = vectorMagnitude(&prototypeVector[prototype_index][0]);
                    magE = vectorMagnitude(&database[feature_index][0]);
                    result = (float)magPE / (beta + (float)magP);
                    test = (float)magE / (beta + (float)MAX_ITEMS);
                    /* Выражение 3.2 */
                    if (result > test)
                    {
                        /* Тест на внимательность / (Выражение 3.3) */
                        if (((float)magPE / (float)magE) < vigilance)
                        {
                            int old;
                            /* Убедиться, что это другой кластер */
                            if (membership[feature_index] != prototype_index)
                            {
                                /* Переместить покупателя в другой кластер */
                                old = membership[feature_index];
                                membership[feature_index] = prototype_index;
                                if (old >= 0)
                                {
                                    members[old]--;
                                    if (members[old] == 0)
                                        numPrototypeVectors--;
                                }
                                members[prototype_index]++;
                                /* Пересчитать векторы прототипы для всех
                                 * кластеров
                                 */
                                if ((old >= 0) && (old < TOTAL_PROTOTYPE_VECTORS))
                                {
                                    updatePrototypeVectors(old);
                                }
                                updatePrototypeVectors(prototype_index);
                                done = 0;
                                break;
                            }
                            else
                            {
                                /* Уже в этом кластере */
                            }
                        } /* Тест на внимательность */
                    }
                }
            } /* Цикл по векторам */
            /* Проверяем, обработан ли вектор */
            if (membership[feature_index] == -1)
            {
                /* Не был найден подходящий кластер – создаем новый * кластер для этого вектора признаков
                 */
                membership[feature_index] = createNewPrototypeVector(&database[feature_index][0]);
                done = 0;
            }
        } /* Цикл по покупателям */
        if (!count--)
            break;
    } /* Закончили */
    return 0;
}
