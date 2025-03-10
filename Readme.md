## Cloud Services Engineer DBOps Project
Проект предназначен для демонстранции работы автоматизации операций с базами данных

## Требования
* Docker 20.10+
* Docker Compose 2.20+
* 1 ГБ свободного места

## Установка и настройка
Чтобы воспользоваться проектом выполните следующее:
```bash
git clone https://github.com/ClarkeFeed/cloud-services-engineer-dbops-project.git
cd cloud-services-engineer-dbops-project
```

## Создание пользователя в postgresql
Создайте нового пользователя PostgreSQL. Под этим пользователем будут выполняться автотесты и миграции.
```sql
CREATE USER store_user WITH PASSWORD 'store_password'; -- Обязательно поменяйте под свои нужды!
```

## Создание БД в postgresql
Создайте новую БД. Команда ниже избавляет от необходимости отдельно выдавать права.
```sql
CREATE DATABASE store OWNER store_user;
```
Если данный способ не работает по каким-то причинам, то можно выполнить это в другом виде.
```sql
CREATE DATABASE store;
ALTER DATABASE store OWNER TO store_user;
GRANT ALL PRIVILEGES ON DATABASE store TO store_user;
```

## Тестовые данные
В проекте предоставлен файлы `insert-data.sh` и `docker-compose.yml`, с помощью которых можно создать тестовую БД, не запуская GitHub Actions. Для этого необходимо запустить docker-compose, сделать файл `insert-data.sh` исполняемым и запустить его.
```bash
#будучи в папке проекта
docker-compose up -d
chmod +x insert-data.sh
./insert-data.sh
```
Не забудь предварительно поменять данные на удобные вам в обоих файлах.

## Подключение к БД
Используйте psql:
```bash
psql -h <IP_address> -p <port> -U store_user -d store
```
Или же внутри сессии:
```shell
\c store
```

## Получение посуточно отправленных заказов за последние 7 дней
Запрос покажет какое количество сосисок было продано за каждый день предыдущей недели.
```sql
SELECT o.date_created, SUM(op.quantity) AS total_sausages
FROM orders AS o
JOIN order_product AS op ON o.id = op.order_id
WHERE o.status = 'shipped' AND o.date_created > now() - INTERVAL '7 DAY'
GROUP BY o.date_created; 
```
