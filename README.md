# TP_HW3 — Docker и Bash

Проект генерирует CSV с данными о животных и строит HTML-отчёт.

## Быстрый старт

```bash
chmod +x run.sh
./run.sh build_generator
./run.sh run_generator
./run.sh build_reporter
./run.sh run_reporter
```

## Команды run.sh

| Команда | Описание |
|---------|----------|
| `build_generator` | Сборка образа генератора |
| `run_generator` | Генерация `data/data.csv` |
| `create_local_data` | Локальная генерация в `local_data/` |
| `build_reporter` | Сборка образа аналитика |
| `run_reporter` | Создание `data/report.html` |
| `structure` | Дерево файлов проекта |
| `clear_data` | Удаление csv и html из `data/` |
| `inside_generator` | Содержимое `/data` внутри генератора |
| `inside_reporter` | Содержимое `/data` внутри аналитика |
| `report_server` | Веб-сервер для просмотра отчёта |

## Просмотр отчёта в GitHub Codespaces

1. Сгенерируйте данные и отчёт:
   ```bash
   ./run.sh run_generator
   ./run.sh run_reporter
   ```

2. Запустите веб-сервер:
   ```bash
   ./run.sh report_server
   ```
   Nginx раздаёт файлы из `data/` на порту 8080 контейнера.

3. Codespaces пробрасывает порт 8080 на виртуальную машину. В VS Code откроется уведомление **Port 8080 is available** — нажмите **Open in Browser**.

4. Если уведомления нет, откройте вкладку **Ports** (нижняя панель), найдите порт 8080 и выберите **Open in Browser**.

5. В браузере перейдите на `http://localhost:8080/report.html`.

### Как это работает

```
Браузер → Codespaces (проброс порта) → Docker (nginx:8080) → data/report.html на хосте
```

- `report.html` лежит в `data/` на хосте Codespaces
- контейнер nginx монтирует эту папку в `/usr/share/nginx/html`
- флаг `-p 8080:80` пробрасывает порт 80 контейнера на 8080 хоста
- Codespaces автоматически делает порт 8080 доступным с вашего компьютера

Остановить сервер:
```bash
docker stop report_server
```
ИНСТРУКЦИЯ ПО ЗАПУСКУ

# 1. Дать права на выполнение
chmod +x run.sh

# 2. Собрать и запустить генератор
./run.sh build_generator
./run.sh run_generator

# 3. Собрать и запустить аналитика (создаст report.html и index.html)
./run.sh build_reporter
./run.sh run_reporter

# 4. Запустить веб-сервер
./run.sh report_server

# 5. Открыть отчёт в браузере
# - В Codespaces: вкладка Ports → порт 8080 → Open in Browser
# - Локально: http://localhost:8080
