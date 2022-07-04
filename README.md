# Нагрузочное тестирование hasql

## Компоненты
* база postgresql (запускается [сервисным контейнером](https://docs.github.com/en/actions/using-containerized-services/creating-postgresql-service-containers) к тестам)
* odyssey как основной пулер
* pgbouncer как альтернативный пулер
* тестирующий сервис на Хаскеле
* Яндекс-танк
* pgbench для сравнения
* сценарии запуска всех тестов с аргументами - параметрами имён запросов - в виде GitHub Actions
