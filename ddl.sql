-- =====================================================================
-- SUPERSTORE 3NF RELATIONAL SCHEMA DDL
-- =====================================================================

-- 1. Customers Dimension Table
CREATE TABLE dim_customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(255) NOT NULL,
    Segment VARCHAR(100) NOT NULL
);

-- 2. Locations Dimension Table
CREATE TABLE dim_locations (
    Postal_Code VARCHAR(20) PRIMARY KEY,
    Country VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL
);

-- 3. Products Dimension Table
CREATE TABLE dim_products (
    Product_ID VARCHAR(50) PRIMARY KEY,
    Product_Name VARCHAR(255) NOT NULL,
    Sub_Category VARCHAR(100) NOT NULL,
    Category VARCHAR(100) NOT NULL
);

-- 4. Orders Fact Table (Header)
CREATE TABLE fact_orders (
    Order_ID VARCHAR(50) PRIMARY KEY,
    Customer_ID VARCHAR(50) NOT NULL,
    Postal_Code VARCHAR(20) NOT NULL,
    Order_Date DATE NOT NULL,
    Ship_Date DATE NOT NULL,
    Ship_Mode VARCHAR(50) NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (Customer_ID) 
        REFERENCES dim_customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_orders_location FOREIGN KEY (Postal_Code) 
        REFERENCES dim_locations(Postal_Code)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 5. Order Items Fact Table (Line Items)
CREATE TABLE fact_order_items (
    Row_ID INTEGER PRIMARY KEY,
    Order_ID VARCHAR(50) NOT NULL,
    Product_ID VARCHAR(50) NOT NULL,
    Sales DECIMAL(10, 4) NOT NULL,
    CONSTRAINT fk_items_order FOREIGN KEY (Order_ID) 
        REFERENCES fact_orders(Order_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_items_product FOREIGN KEY (Product_ID) 
        REFERENCES dim_products(Product_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- =====================================================================
-- PERFORMANCE INDEXES
-- =====================================================================
CREATE INDEX idx_orders_customer ON fact_orders(Customer_ID);
CREATE INDEX idx_orders_location ON fact_orders(Postal_Code);
CREATE INDEX idx_items_order ON fact_order_items(Order_ID);
CREATE INDEX idx_items_product ON fact_order_items(Product_ID);