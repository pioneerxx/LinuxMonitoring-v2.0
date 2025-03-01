# Linux Monitoring 2.0
### by danyellt

#### Перед началом проверки убедитесь, что выполнили следующий проброс портов:

4444:4444
9090:9090
3000:3000

## Part 1. Генератор файлов

1. Написать bash-скрипт. Скрипт запускается с 6 параметрами. Пример запуска скрипта: 
```main.sh /opt/test 4 az 5 az.az 3kb```

**Параметр 1** - это абсолютный путь. 
**Параметр 2** - количество вложенных папок. 
**Параметр 3** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
**Параметр 4** - количество файлов в каждой созданной папке. 
**Параметр 5** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
**Параметр 6** - размер файлов (в килобайтах, но не более 100).

2. Выполнение скрипта:

![linux](screens/1.png)

![linux](screens/2.png)

![linux](screens/3.png)


## Part 2. Засорение файловой системы

1. Написать bash-скрипт. Скрипт запускается с 3 параметрами. Пример запуска скрипта: 
```main.sh az az.az 3Mb```

**Параметр 1** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
**Параметр 2** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
**Параметр 3** - размер файла (в Мегабайтах, но не более 100).

2. Свободная память в килобайтах до выполнения скрипта:

![linux](screens/4.png)

3. Выполнение скрипта:

![linux](screens/5.png)

4. Свободная память в килобайтах после выполнения скрипта:

![linux](screens/6.png)

5. Логфайл

![linux](screens/7.png)

## Part 3. Очистка файловой системы

1. Написать bash-скрипт. Скрипт запускается с 1 параметром.
Скрипт должен уметь очистить систему от созданных в Part 2 папок и файлов 3 способами:
По лог файлу
По дате и времени создания
По маске имени (т.е. символы, нижнее подчёркивание и дата).

2. Запуск скрипта по первому методу:

![linux](screens/8.png)

3. Запуск скрипты по второму методу:

![linux](screens/9.png)

4. Запуск скрипта по третьему методу:

![linux](screens/10.png)

5. Свободная память в килобайтах после выполнения скрипта:

![linux](screens/11.png)

## Part 4. Генератор логов

1. Написать bash-скрипт или программу на Си, генерирующий 5 файлов логов nginx в combined формате.
Каждый лог должен содержать информацию за 1 день.
За день должно быть сгенерировано случайное число записей от 100 до 1000.
Для каждой записи должны случайным образом генерироваться:

IP (любые корректные, т.е. не должно быть ip вида 999.111.777.777)
Коды ответа (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
Методы (GET, POST, PUT, PATCH, DELETE)
Даты (в рамках заданного дня лога, должны идти по увеличению)
URL запроса агента
Агенты (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

2. Выполнение скрипта

![linux](screens/12.png)

3. Логфайлы

![linux](screens/13.png)

## Part 5. Мониторинг

1. Написать bash-скрипт для разбора логов nginx из Части 4 через awk.
Скрипт запускается с 1 параметром, который принимает значение 1, 2, 3 или 4.
В зависимости от значения параметра вывести:

*1*) Все записи, отсортированные по коду ответа
*2)* Все уникальные IP, встречающиеся в записях
*3)* Все запросы с ошибками (код ответа - 4хх или 5хх)
*4)* Все уникальные IP, которые встречаются среди ошибочных запросов

2. Запуск скрипта с параметром 1

![linux](screens/14.png)

3. Запуск скрипта с параметром 2

![linux](screens/15.png)

4. Запуск скрипта с параметром 3

![linux](screens/16.png)

5. Запуск скрипта с параметром 4

![linux](screens/17.png)

## Part 6. GoAccess

1. С помощью утилиты GoAccess получить ту же информацию, что и в Части 5
Открыть веб интерфейс утилиты на локальной машине.

2. Устанавливаем необходимые утилиты скриптом installResources.sh

![linux](screens/18.png)

3. Запуск скрипта

![linux](screens/19.png)

4. Веб-интерфейс

![linux](screens/20.png)

## Part 7. Prometheus и Grafana

1. Установить и настроить Prometheus и Grafana на виртуальную машину

![linux](screens/21.png)

2. Получить доступ к веб интерфейсам Prometheus и Grafana с локальной машины

![linux](screens/22.png)

![linux](screens/23.png)

Указали Prometheus как источник данных для Grafana

![linux](screens/24.png)

3. Добавить на дашборд Grafana отображение ЦПУ, доступной оперативной памяти, свободное место и кол-во операций ввода/вывода на жестком диске

![linux](screens/25.png)

4. Запустить ваш bash-скрипт из Части 2

![linux](screens/26.png)

5. Посмотреть на нагрузку жесткого диска (место на диске и операции чтения/записи)

![linux](screens/27.png)

6. Установить утилиту stress и запустить команду stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s

![linux](screens/29.png)

7. Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ

![linux](screens/28.png)

## Part 8. Готовый дашборд

1. Установить готовый дашборд Node Exporter Quickstart and Dashboard с официального сайта Grafana Labs

![linux](screens/30.png)

2. Провести те же тесты, что и в Части 7

*1)* Скрипт из второй части

![linux](screens/31.png)

![linux](screens/32.png)

*2)* stress

![linux](screens/33.png)

![linux](screens/34.png)

3. Запустить ещё одну виртуальную машину, находящуюся в одной сети с текущей

![linux](screens/35.png)

4. Запустить тест нагрузки сети с помощью утилиты iperf3

![linux](screens/36.png)

5. Посмотреть на нагрузку сетевого интерфейса

![linux](screens/37.png)

## Part 9. Дополнительно. Свой node_exporter

1. Написать bash-скрипт или программу на Си, которая собирает информацию по базовым метрикам системы (ЦПУ, оперативная память, жесткий диск (объем)).
Скрипт или программа должна формировать html страничку по формату Prometheus, которую будет отдавать nginx. 
Саму страничку обновлять можно как внутри bash-скрипта или программы (в цикле), так и при помощи утилиты cron, но не чаще, чем раз в 3 секунды.

Файл installResources.sh, устанавливающий необходимые утилиты и создающий сервис для работы нашего Node Exporter в фоновом режиме

![linux](screens/40.png)

Файл SystemMetrics.sh, собирающий информацию о системе

![linux](screens/38.png)

Файл MyNodeExporter.sh, выводящий информацию в .html файл

![linux](screens/39.png)

2. Поменять конфигурационный файл Prometheus, чтобы он собирал информацию с созданной вами странички.

Файл конфигурации nginx:

![linux](screens/41.png)

Файл конфигурации Prometheus:

![linux](screens/42.png)

Страничка nginx:

![linux](screens/43.png)

Цель собирается:

![linux](screens/44.png)

3. Провести те же тесты, что и в Части 7

Спокойное состояние:

![linux](screens/45.png)

*1)* Скрипт из второй части

![linux](screens/46.png)

*2)* stress

![linux](screens/47.png)
