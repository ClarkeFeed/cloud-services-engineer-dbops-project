## Создание пользователя в postgresql
Создайте нового пользователя PostgreSQL. Под этим логином будут ходить автотесты и выполняться миграции.
```sql
CREATE USER store_user WITH PASSWORD 'store_password';
```

## Создание БД в postgresql
Создайте новую БД и укажите владельцем данной БД -- созданного ранее пользователя.
```sql
CREATE DATABASE store OWNER store_user;
```

## Подключение к базе
```shell
\c store
```

## Получение посуточно отправленных заказов за последние 7 дней
Запрос покажет какое количество сосисок было продано за каждый день предыдущей недели.
```sql
SELECT o.date_created, SUM(op.quantity) 
FROM orders AS o
JOIN order_product AS op ON o.id = op.order_id
WHERE o.status = 'shipped' AND o.date_created > now() - INTERVAL '7 DAY'
GROUP BY o.date_created; 
```