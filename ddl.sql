CREATE TABLE dim_gender (
    gender_id INT AUTO_INCREMENT PRIMARY KEY,
    gender_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE dim_customer_type (
    customer_type_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_type_name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE dim_travel_type (
    travel_type_id INT AUTO_INCREMENT PRIMARY KEY,
    travel_type_name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE dim_flight_class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE dim_satisfaction (
    satisfaction_id INT AUTO_INCREMENT PRIMARY KEY,
    satisfaction_label VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    age INT NOT NULL CHECK (age > 0),
    gender_id INT NOT NULL,
    customer_type_id INT NOT NULL,
    FOREIGN KEY (gender_id) REFERENCES dim_gender(gender_id),
    FOREIGN KEY (customer_type_id) REFERENCES dim_customer_type(customer_type_id)
);

CREATE TABLE flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_distance INT NOT NULL,
    departure_delay_minutes INT NOT NULL DEFAULT 0,
    arrival_delay_minutes DECIMAL(10, 2) NULL
);

CREATE TABLE trip_bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT UNIQUE NOT NULL,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    travel_type_id INT NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    FOREIGN KEY (travel_type_id) REFERENCES dim_travel_type(travel_type_id),
    FOREIGN KEY (class_id) REFERENCES dim_flight_class(class_id)
);

CREATE TABLE pre_flight_ratings (
    survey_id INT PRIMARY KEY,
    departure_arrival_time_convenient SMALLINT CHECK (departure_arrival_time_convenient BETWEEN 0 AND 5),
    ease_of_online_booking SMALLINT CHECK (ease_of_online_booking BETWEEN 0 AND 5),
    gate_location SMALLINT CHECK (gate_location BETWEEN 0 AND 5),
    online_boarding SMALLINT CHECK (online_boarding BETWEEN 0 AND 5),
    checkin_service SMALLINT CHECK (checkin_service BETWEEN 0 AND 5),
    FOREIGN KEY (survey_id) REFERENCES trip_bookings(survey_id)
);

CREATE TABLE inflight_ratings (
    survey_id INT PRIMARY KEY,
    inflight_wifi_service SMALLINT CHECK (inflight_wifi_service BETWEEN 0 AND 5),
    food_and_drink SMALLINT CHECK (food_and_drink BETWEEN 0 AND 5),
    seat_comfort SMALLINT CHECK (seat_comfort BETWEEN 0 AND 5),
    inflight_entertainment SMALLINT CHECK (inflight_entertainment BETWEEN 0 AND 5),
    on_board_service SMALLINT CHECK (on_board_service BETWEEN 0 AND 5),
    leg_room_service SMALLINT CHECK (leg_room_service BETWEEN 0 AND 5),
    inflight_service SMALLINT CHECK (inflight_service BETWEEN 0 AND 5),
    cleanliness SMALLINT CHECK (cleanliness BETWEEN 0 AND 5),
    FOREIGN KEY (survey_id) REFERENCES trip_bookings(survey_id)
);

CREATE TABLE arrival_ratings (
    survey_id INT PRIMARY KEY,
    baggage_handling SMALLINT CHECK (baggage_handling BETWEEN 0 AND 5),
    FOREIGN KEY (survey_id) REFERENCES trip_bookings(survey_id)
);

CREATE TABLE satisfaction_outcomes (
    survey_id INT PRIMARY KEY,
    satisfaction_id INT NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES trip_bookings(survey_id),
    FOREIGN KEY (satisfaction_id) REFERENCES dim_satisfaction(satisfaction_id)
);

SHOW TABLES;