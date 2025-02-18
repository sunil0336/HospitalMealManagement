CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phoneno VARCHAR(15) UNIQUE NOT NULL
);



CREATE TABLE dietitian (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phoneno VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE delivery_partner (
    id int PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    order_id INT
);


INSERT INTO patients (name, phoneno)
VALUES ('Sunil Rathod', '9890957016');



-- new ***********
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    room_number INT NOT NULL CHECK (room_number BETWEEN 1 AND 5),
    breakfast_status BOOLEAN NOT NULL DEFAULT FALSE,  -- FALSE = Not Ordered, TRUE = Ordered
    lunch_status BOOLEAN NOT NULL DEFAULT FALSE,
    dinner_status BOOLEAN NOT NULL DEFAULT FALSE,
    comments TEXT,  -- Comments column added for room-specific notes
    order_status BOOLEAN NOT NULL DEFAULT FALSE, -- Overall order status: FALSE = Not Ordered, TRUE = Ordered
    scheduled_time TIME[], -- When the meal is scheduled
    delivered_time TIME[], -- When the meal is delivered
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    delivery_permission BOOLEAN NOT NULL DEFAULT FALSE -- Delivery permission: TRUE = Allowed, FALSE = Not Allowed
);

-- Insert sample data with individual meal status, comments, and delivery permission
INSERT INTO orders (room_number, breakfast_status, lunch_status, dinner_status, order_status, scheduled_time, comments, delivery_permission) 
VALUES 
(1, TRUE, FALSE, FALSE, TRUE, 
    ARRAY['08:00:00'::TIME, '09:00:00'::TIME, '10:00:00'::TIME],  -- Scheduled breakfast times
    'Room requested breakfast early due to early meeting',  -- Comments
    TRUE),

(2, FALSE, TRUE, FALSE, TRUE, 
    ARRAY['07:30:00'::TIME, '08:30:00'::TIME, '09:30:00'::TIME],  -- Scheduled breakfast times
    'Guest requested lunch at 1 PM', 
    TRUE),

(3, TRUE, TRUE, FALSE, TRUE, 
    ARRAY['06:30:00'::TIME, '07:30:00'::TIME, '08:30:00'::TIME],  -- Scheduled breakfast times
    'Guest prefers breakfast and lunch to be served in their room', 
    TRUE),

(4, FALSE, FALSE, TRUE, FALSE, 
    ARRAY['08:00:00'::TIME, '09:00:00'::TIME, '10:00:00'::TIME],  -- Scheduled breakfast times
    'Dinner to be served at 7 PM', 
    FALSE),

(5, TRUE, TRUE, TRUE, TRUE, 
    ARRAY['07:00:00'::TIME, '08:00:00'::TIME, '09:00:00'::TIME],  -- Scheduled breakfast times
    'Guest has requested all meals delivered on time', 
    TRUE);


SELECT * FROM orders;
SELECT scheduled_time[2] AS first_scheduled_time FROM orders;


UPDATE orders
SET 
    breakfast_status = TRUE, 
    lunch_status = FALSE, 
    dinner_status = TRUE, 
    comments = 'Please make sure the food is gluten-free.', 
    delivery_permission = TRUE,
	delivered_time = ARRAY['06:30:00'::TIME, '07:30:00'::TIME, '08:30:00'::TIME]
WHERE id = 1
RETURNING *;




