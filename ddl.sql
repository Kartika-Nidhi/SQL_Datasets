-- ==========================================
-- TRIP / BOOKING CONTEXT
-- ==========================================
CREATE TABLE trip_bookings (
    booking_id SERIAL PRIMARY KEY,
    survey_id INT UNIQUE NOT NULL, -- Maps to original 'id'
    passenger_id INT NOT NULL REFERENCES passengers(passenger_id),
    flight_id INT NOT NULL REFERENCES flights(flight_id),
    travel_type_id INT NOT NULL REFERENCES dim_travel_type(travel_type_id),
    class_id INT NOT NULL REFERENCES dim_flight_class(class_id)
);

-- ==========================================
-- TOUCHPOINT RATING TABLES
-- ==========================================
CREATE TABLE pre_flight_ratings (
    survey_id INT PRIMARY KEY REFERENCES trip_bookings(survey_id),
    departure_arrival_time_convenient SMALLINT CHECK (departure_arrival_time_convenient BETWEEN 0 AND 5),
    ease_of_online_booking SMALLINT CHECK (ease_of_online_booking BETWEEN 0 AND 5),
    gate_location SMALLINT CHECK (gate_location BETWEEN 0 AND 5),
    online_boarding SMALLINT CHECK (online_boarding BETWEEN 0 AND 5),
    checkin_service SMALLINT CHECK (checkin_service BETWEEN 0 AND 5)
);

CREATE TABLE inflight_ratings (
    survey_id INT PRIMARY KEY REFERENCES trip_bookings(survey_id),
    inflight_wifi_service SMALLINT CHECK (inflight_wifi_service BETWEEN 0 AND 5),
    food_and_drink SMALLINT CHECK (food_and_drink BETWEEN 0 AND 5),
    seat_comfort SMALLINT CHECK (seat_comfort BETWEEN 0 AND 5),
    inflight_entertainment SMALLINT CHECK (inflight_entertainment BETWEEN 0 AND 5),
    on_board_service SMALLINT CHECK (on_board_service BETWEEN 0 AND 5),
    leg_room_service SMALLINT CHECK (leg_room_service BETWEEN 0 AND 5),
    inflight_service SMALLINT CHECK (inflight_service BETWEEN 0 AND 5),
    cleanliness SMALLINT CHECK (cleanliness BETWEEN 0 AND 5)
);

CREATE TABLE arrival_ratings (
    survey_id INT PRIMARY KEY REFERENCES trip_bookings(survey_id),
    baggage_handling SMALLINT CHECK (baggage_handling BETWEEN 0 AND 5)
);

-- ==========================================
-- SURVEY OUTCOME / TARGET
-- ==========================================
CREATE TABLE satisfaction_outcomes (
    survey_id INT PRIMARY KEY REFERENCES trip_bookings(survey_id),
    satisfaction_id INT NOT NULL REFERENCES dim_satisfaction(satisfaction_id)
);

SHOW TABLES;