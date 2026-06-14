# ДЗ3 Docker Bash

Проект генерирует csv с данными о животных и html отчет. Генератор и аналитик работают в разных docker контейнерах, файлы лежат на хосте в папке data.

Структура:

- run.sh — главный скрипт
- generate.py — генерация csv
- report.js, package.json — аналитик
- generator/Dockerfile — образ генератора
- reporter/Dockerfile — образ аналитика
- data/ — сгенерированные файлы

Колонки в csv: animal, age, weight, habitat.

Запуск с нуля:

    chmod +x run.sh
    ./run.sh build_generator
    ./run.sh run_generator
    ./run.sh build_reporter
    ./run.sh run_reporter
    ./run.sh report_server

После run_generator появится data/data.csv
После run_reporter появится data/report.html и data/index.html

Команды run.sh:

build_generator — собрать образ генератора
run_generator — создать data/data.csv на хосте
create_local_data — создать local_data/data.csv без docker
build_reporter — собрать образ аналитика
run_reporter — создать data/report.html на хосте
structure — показать дерево файлов проекта
clear_data — полностью очистить папку data
inside_generator — ls /data внутри контейнера генератора
inside_reporter — ls /data внутри контейнера аналитика
report_server — запустить nginx для просмотра отчета

Просмотр отчета в GitHub Codespaces

1. Открыть репозиторий в codespaces (Code -> Codespaces -> Create codespace)

2. В терминале выполнить:

    chmod +x run.sh
    ./run.sh build_generator
    ./run.sh run_generator
    ./run.sh build_reporter
    ./run.sh run_reporter

3. Проверить что файлы есть:

    ls data/

    должны быть data.csv report.html index.html

4. Запустить сервер:

    ./run.sh report_server

5. Открыть вкладку Ports внизу в vscode. Найти порт 8080. Нажать Open in Browser.

6. В браузере открыть http://localhost:8080/report.html
   можно также просто http://localhost:8080 — там index.html

Как это работает

Сервер nginx крутится в docker контейнере. Папка data с хоста монтируется в /usr/share/nginx/html внутри контейнера. Флаг -p 8080:80 пробрасывает порт 80 контейнера на 8080 хоста codespaces. Codespaces в свою очередь пробрасывает этот порт на твой компьютер через вкладку Ports. Поэтому цепочка такая:

браузер на твоем пк -> codespaces порт 8080 -> docker nginx -> data/report.html на диске

Если что-то не работает

Порт 8080 не появился в Ports — добавить вручную через Add Port, вписать 8080.

Ошибка 404 на report.html — сначала запустить run_reporter, потом report_server.

Ошибка 403 или 404 — скорее всего сервер запущен до того как появились файлы, или после clear_data. Нужно перезапустить сервер:

    docker stop report_server
    ./run.sh report_server

Потом открыть http://localhost:8080/report.html или http://localhost:8080/

docker ps не показывает report_server — запустить ./run.sh report_server еще раз.

Проверить что сервер отвечает прямо в терминале codespaces:

    curl -I http://localhost:8080/report.html

должно быть HTTP/1.1 200 OK

Остановить сервер:

    docker stop report_server

Очистить и пересоздать данные:

    ./run.sh clear_data
    ./run.sh run_generator
    ./run.sh run_reporter
    ./run.sh report_server

Локально (без codespaces) те же команды, потом открыть http://localhost:8080/report.html
