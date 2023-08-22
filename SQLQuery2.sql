CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    Category NVARCHAR(50),
    Price DECIMAL(10, 2),
    Description NVARCHAR(500)
);
GO
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(255)
);
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    Status NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    HireDate DATE
);
GO
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    StockQuantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO
INSERT INTO Products (ProductID, ProductName, Category, Price, Description)
VALUES
    (1, 'Caffè Americano', 'Coffee', 3.99, 'Espresso shots topped with hot water.'),
    (2, 'Caramel Macchiato', 'Coffee', 4.99, 'Espresso shots with steamed milk and caramel.'),
    (3, 'Chocolate Croissant', 'Pastry', 2.49, 'Flaky croissant filled with chocolate.'),
    (4, 'Iced Tea', 'Tea', 2.79, 'Refreshing iced tea.'),
    (5, 'Vanilla Latte', 'Coffee', 4.49, 'Espresso with steamed milk and vanilla syrup.');
GO
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
    (1, 'John', 'Doe', 'john@example.com', '123-456-7890', '123 Main St'),
    (2, 'Jane', 'Smith', 'jane@example.com', '987-654-3210', '456 Elm St'),
    (3, 'Michael', 'Johnson', 'michael@example.com', '555-123-4567', '789 Oak Ave'),
    (4, 'Emily', 'Brown', 'emily@example.com', '777-888-9999', '101 Pine Rd'),
    (5, 'David', 'Williams', 'david@example.com', '444-555-6666', '222 Cedar Ln');
	GO
	INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status)
VALUES
    (1, 3, '2023-08-15 10:30:00', 7.99, 'Completed'),
    (2, 1, '2023-08-16 15:45:00', 9.98, 'Pending'),
    (3, 5, '2023-08-17 12:00:00', 4.49, 'Completed'),
    (4, 2, '2023-08-18 09:20:00', 12.47, 'Completed'),
    (5, 4, '2023-08-19 14:00:00', 9.97, 'Pending');
	GO
	INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 2, 1, 4.99),
    (2, 1, 4, 2, 2.79),
    (3, 2, 1, 2, 3.99),
    (4, 3, 5, 1, 4.49),
    (5, 4, 3, 3, 2.49);
	GO
	INSERT INTO Employees (EmployeeID, FirstName, LastName, Position, HireDate)
VALUES
    (1, 'Sarah', 'Johnson', 'Barista', '2021-05-10'),
    (2, 'Daniel', 'Smith', 'Manager', '2019-02-15'),
    (3, 'Emily', 'Williams', 'Cashier', '2022-08-01'),
    (4, 'Michael', 'Brown', 'Barista', '2023-01-20'),
    (5, 'Jessica', 'Jones', 'Barista', '2023-07-08');
	GO
	INSERT INTO Inventory (ProductID, StockQuantity)
VALUES
    (1, 100),
    (2, 75),
    (3, 50),
    (4, 200),
    (5, 60);
	GO
	--đếm số lượng sản phẩm hiện tại 
	SELECT ProductID, COUNT(*)[ProductNumber] FROM Products
		GROUP BY ProductID WITH CUBE
--tìm kiếm sản phẩm theo tên 
	SELECT*FROM Products
	WHERE ProductName LIKE 'Caramel Macchiato'
	--tím kiếm sản phẩm theo giá 
	SELECT*FROM Products
	WHERE Price LIKE '4.49'
	-- tìm khác hàng theo tên 
	SELECT*FROM Customers
	WHERE LastName LIKE 'j%'
	-- lấy thông tin của đơn hàng hiện tại theo tên khách hàng 
	SELECT* FROM Orders INNER JOIN Customers ON 
	Customers.LastName LIKE 'Doe'
	--lấy thông tin sản phẩm bán chạy nhất
	SELECT*FROM Inventory
	ORDER BY StockQuantity ASC
