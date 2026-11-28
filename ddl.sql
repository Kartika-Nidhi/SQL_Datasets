-- 1. Luxury Houses
CREATE TABLE houses (
    house_id INT AUTO_INCREMENT PRIMARY KEY,
    house_code VARCHAR(100) NOT NULL UNIQUE,
    house_name VARCHAR(150) NOT NULL
);

-- 2. Merchandising Categories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    product_type VARCHAR(100),
    UNIQUE KEY uq_taxonomy (department, category, product_type)
);

-- 3. Regional Storefronts
CREATE TABLE storefronts (
    storefront_id INT AUTO_INCREMENT PRIMARY KEY,
    storefront_code VARCHAR(50) NOT NULL UNIQUE,
    default_currency CHAR(3) NOT NULL
);

-- 4. Materials & Colors
CREATE TABLE materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE colors (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Master Products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    house_id INT NOT NULL,
    article_code VARCHAR(100) NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category_id INT,
    material_id INT,
    color_id INT,
    made_in VARCHAR(100),
    dimensions VARCHAR(150),
    UNIQUE KEY uq_house_article (house_id, article_code),
    CONSTRAINT fk_prod_house FOREIGN KEY (house_id) REFERENCES houses(house_id),
    CONSTRAINT fk_prod_cat FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT fk_prod_mat FOREIGN KEY (material_id) REFERENCES materials(material_id),
    CONSTRAINT fk_prod_col FOREIGN KEY (color_id) REFERENCES colors(color_id)
);

-- 6. Product Lifecycle Status (1:1 with Products)
CREATE TABLE product_lifecycle (
    product_id INT PRIMARY KEY,
    card_status VARCHAR(50) NOT NULL,
    card_status_week VARCHAR(20) NOT NULL,
    first_seen_week VARCHAR(20) NOT NULL,
    last_seen_week VARCHAR(20) NOT NULL,
    CONSTRAINT fk_life_prod FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 7. Weekly Price & Availability Fact Table
CREATE TABLE price_observations (
    observation_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    storefront_id INT NOT NULL,
    observation_week VARCHAR(20) NOT NULL,
    observed_on DATE NOT NULL,
    availability_status VARCHAR(50),
    currency CHAR(3) NOT NULL,
    local_price DECIMAL(12, 2),
    price_usd DECIMAL(12, 2),
    UNIQUE KEY uq_obs (product_id, storefront_id, observation_week),
    INDEX idx_observed_on (observed_on),
    INDEX idx_storefront_week (storefront_id, observation_week),
    CONSTRAINT fk_obs_prod FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_obs_store FOREIGN KEY (storefront_id) REFERENCES storefronts(storefront_id)
);

SHOW TABLES;