use task1;

create table Customer (
	customer_id INT AUTO_INCREMENT Primary key,
    customer_name VARCHAR(225) NOT NULL
);

create table Employee (
	employee_id INT AUTO_INCREMENT Primary key,
    employee_name VARCHAR(225) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    supervisor_id INT,
    Foreign key (supervisor_id) References Employee(employee_id)
);

create table Product (
	product_id INT AUTO_INCREMENT primary key,
    product_name VARCHAR(225) NOT NULL,
    list_price DECIMAL(10,2) NOT NULL
);
 create table orders(
	order_id INT AUTO_INCREMENT primary key,
    order_date DATETIME NOT NULL,
    total DECIMAL(10,2) ,
	customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    Foreign key (customer_id) References Customer(customer_id),
    Foreign key (employee_id) References Employee(employee_id)
 );
CREATE TABLE LineItem (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Customer (customer_name) VALUES
('Nguyễn Văn A'),
('Trần Thị B'),
('Lê Hoàng C'),
('Phạm Thị D');

INSERT INTO Employee (employee_name, salary, supervisor_id) VALUES
('Ngô Minh Quân', 20000.00, NULL),   
('Võ Thị Lan', 15000.00, 1),
('Phan Hữu Tài', 16000.00, 1),
('Đặng Thùy Trang', 14000.00, 2);

INSERT INTO Product (product_name, list_price) VALUES
('Trà sữa trân châu', 30000.00),
('Hồng trà kem cheese', 35000.00),
('Matcha đá xay', 40000.00),
('Trà đào cam sả', 32000.00);

INSERT INTO Orders (order_date, total, customer_id, employee_id) VALUES
(NOW(), 30000.00, 1, 1),
(NOW(), 67000.00, 2, 2),
(NOW(), 40000.00, 3, 3),
(NOW(), 62000.00, 4, 4);


INSERT INTO LineItem (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 30000.00), 
(2, 1, 1, 30000.00), 
(2, 2, 1, 35000.00),
(3, 3, 1, 40000.00); 

select * from Customer;
select * from Orders;
select * from LineItem;

SELECT order_id, SUM(quantity * price) AS total
FROM LineItem
WHERE order_id = 3
GROUP BY order_id;

DELIMITER //

CREATE PROCEDURE AddCustomer(IN p_name VARCHAR(100))
BEGIN
    INSERT INTO Customer (customer_name)
    VALUES (p_name);
END //

DELIMITER ;

CALL AddCustomer('Nguyễn Văn B');


DELIMITER //

CREATE PROCEDURE DeleteCustomer(IN p_customer_id INT)
BEGIN
    -- Xóa LineItem liên quan tới các đơn hàng của customer này
    DELETE FROM LineItem
    WHERE order_id IN (
        SELECT order_id FROM Orders WHERE customer_id = p_customer_id
    );

    -- Xóa Orders của customer này
    DELETE FROM Orders
    WHERE customer_id = p_customer_id;

    -- Xóa customer
    DELETE FROM Customer
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;

CALL DeleteCustomer(3);

DELIMITER //

CREATE PROCEDURE UpdateCustomer(
    IN p_customer_id INT,
    IN p_new_name VARCHAR(225)
)
BEGIN
    UPDATE Customer
    SET customer_name = p_new_name
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;

CALL UpdateCustomer(2, 'Trần Thị Bích Ngọc');

DELIMITER //

CREATE PROCEDURE CreateOrder(
    IN p_order_date DATETIME,
    IN p_customer_id INT,
    IN p_employee_id INT
)
BEGIN
    INSERT INTO Orders (order_date, total, customer_id, employee_id)
    VALUES (p_order_date, 0, p_customer_id, p_employee_id);
END //

DELIMITER ;

CALL CreateOrder(NOW(), 1, 1);

DELIMITER //

CREATE PROCEDURE CreateLineItem(
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    INSERT INTO LineItem (order_id, product_id, quantity, price)
    VALUES (p_order_id, p_product_id, p_quantity, p_price);
END //

DELIMITER ;

CALL CreateLineItem(1, 2, 3, 35000);

DELIMITER //

CREATE PROCEDURE UpdateOrderTotal(
    IN p_order_id INT
)
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(quantity * price)
    INTO v_total
    FROM LineItem
    WHERE order_id = p_order_id;

    UPDATE Orders
    SET total = IFNULL(v_total, 0)
    WHERE order_id = p_order_id;
END //

DELIMITER ;

CALL UpdateOrderTotal(1);




