
-- ============================================
-- FOOD DELIVERY MANAGEMENT DATABASE
-- ============================================



-- ============================================
-- 1. CITIES
-- ============================================

CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    metro_city VARCHAR(100) NOT NULL UNIQUE
);


-- ============================================
-- 2. RESTAURANT PROFILES
-- ============================================

CREATE TABLE restaurant_profiles (
    restaurant_profile_id INT AUTO_INCREMENT PRIMARY KEY,
    cuisine_category VARCHAR(100) NOT NULL,
    restaurant_price_tier VARCHAR(30) NOT NULL,

    UNIQUE (cuisine_category, restaurant_price_tier)
);


-- ============================================
-- 3. ORDER CHANNELS
-- ============================================

CREATE TABLE order_channels (
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    order_channel VARCHAR(50) NOT NULL UNIQUE
);


-- ============================================
-- 4. DELIVERY CONDITIONS
-- ============================================

CREATE TABLE delivery_conditions (
    condition_id INT AUTO_INCREMENT PRIMARY KEY,
    weather_condition VARCHAR(50) NOT NULL,
    is_peak_hour BOOLEAN NOT NULL,

    UNIQUE (weather_condition, is_peak_hour)
);


-- ============================================
-- 5. ORDERS
-- ============================================

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,

    city_id INT NOT NULL,
    restaurant_profile_id INT NOT NULL,
    channel_id INT NOT NULL,

    order_value_usd DECIMAL(12,2) NOT NULL,
    discount_applied_usd DECIMAL(12,2) NOT NULL DEFAULT 0.00,

    customer_spending_tier VARCHAR(50),

    CONSTRAINT fk_orders_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id),

    CONSTRAINT fk_orders_restaurant_profile
        FOREIGN KEY (restaurant_profile_id)
        REFERENCES restaurant_profiles(restaurant_profile_id),

    CONSTRAINT fk_orders_channel
        FOREIGN KEY (channel_id)
        REFERENCES order_channels(channel_id),

    CONSTRAINT chk_order_value
        CHECK (order_value_usd >= 0),

    CONSTRAINT chk_order_discount
        CHECK (
            discount_applied_usd >= 0
            AND discount_applied_usd <= order_value_usd
        )
);


-- ============================================
-- 6. DELIVERIES
-- ============================================

CREATE TABLE deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id VARCHAR(50) NOT NULL UNIQUE,
    condition_id INT NOT NULL,

    delivery_distance_km DECIMAL(10,2),
    estimated_prep_time_min INT,
    actual_delivery_time_min DECIMAL(10,2),
    delivery_fee_usd DECIMAL(12,2),

    CONSTRAINT fk_deliveries_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_deliveries_condition
        FOREIGN KEY (condition_id)
        REFERENCES delivery_conditions(condition_id),

    CONSTRAINT chk_delivery_distance
        CHECK (delivery_distance_km >= 0),

    CONSTRAINT chk_prep_time
        CHECK (estimated_prep_time_min >= 0),

    CONSTRAINT chk_delivery_time
        CHECK (actual_delivery_time_min >= 0),

    CONSTRAINT chk_delivery_fee
        CHECK (delivery_fee_usd >= 0)
);


-- ============================================
-- 7. CUSTOMER FEEDBACK
-- ============================================

CREATE TABLE customer_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id VARCHAR(50) NOT NULL UNIQUE,

    customer_rating DECIMAL(3,2),
    customer_satisfaction_tier VARCHAR(50),
    primary_satisfaction_driver VARCHAR(150),

    CONSTRAINT fk_feedback_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT chk_customer_rating
        CHECK (
            customer_rating IS NULL
            OR customer_rating BETWEEN 0 AND 5
        )
);

-- ============================================
-- 8. BUSINESS INSIGHTS
-- ============================================

CREATE TABLE business_insights (
    insight_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id VARCHAR(50) NOT NULL UNIQUE,

    logistics_friction_index DECIMAL(10,4),
    estimated_restaurant_net_margin_usd DECIMAL(12,2),
    cot_market_dynamics_rationale TEXT,
    confidence_score DECIMAL(5,4),

    CONSTRAINT fk_insights_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT chk_confidence_score
        CHECK (
            confidence_score IS NULL
            OR confidence_score BETWEEN 0 AND 1
        )
);

SHOW TABLES;