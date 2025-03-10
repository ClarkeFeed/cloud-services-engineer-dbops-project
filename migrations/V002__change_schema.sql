-- Изменяем таблицы, столбцы и данные из них
ALTER TABLE product ADD price DOUBLE PRECISION;
ALTER TABLE product ADD PRIMARY KEY (id);
ALTER TABLE orders ADD date_created date;
ALTER TABLE orders ADD PRIMARY KEY (id);

-- Удаляем ненужные таблицы
DROP TABLE product_info;
DROP TABLE orders_date;

-- Добавляем foreign keys
ALTER TABLE order_product ADD CONSTRAINT fk_product_id FOREIGN KEY(product_id) REFERENCES product(id);
ALTER TABLE order_product ADD CONSTRAINT fk_orders_id FOREIGN KEY(order_id) REFERENCES orders(id);