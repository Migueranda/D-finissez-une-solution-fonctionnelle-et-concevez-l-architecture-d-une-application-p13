CREATE TABLE `Users` (
  `user_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `address_id` UUID NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `Agencies` (
  `agency_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `name` VARCHAR(255) NOT NULL,
  `address_id` UUID NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `Vehicles` (
  `vehicle_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `category` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `model` VARCHAR(255) NOT NULL,
  `year` YEAR NOT NULL,
  `daily_rate` DECIMAL(10,2) NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `Rentals` (
  `rental_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `user_id` UUID NOT NULL,
  `vehicle_id` UUID NOT NULL,
  `agency_pickup_id` UUID NOT NULL,
  `agency_dropoff_id` UUID NOT NULL,
  `pickup_date` TIMESTAMP NOT NULL,
  `dropoff_date` TIMESTAMP NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `Payments` (
  `payment_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `rental_id` UUID NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `payment_date` TIMESTAMP,
  `payment_method` VARCHAR(255),
  `status` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CustomerSupport` (
  `ticket_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `user_id` UUID NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `Addresses` (
  `address_id` UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  `street` VARCHAR(255) NOT NULL,
  `street_number` VARCHAR(20) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `zip_code` VARCHAR(20) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

ALTER TABLE `Users` ADD FOREIGN KEY (`address_id`) REFERENCES `Addresses` (`address_id`);

ALTER TABLE `Agencies` ADD FOREIGN KEY (`address_id`) REFERENCES `Addresses` (`address_id`);

ALTER TABLE `Rentals` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Rentals` ADD FOREIGN KEY (`vehicle_id`) REFERENCES `Vehicles` (`vehicle_id`);

ALTER TABLE `Rentals` ADD FOREIGN KEY (`agency_pickup_id`) REFERENCES `Agencies` (`agency_id`);

ALTER TABLE `Rentals` ADD FOREIGN KEY (`agency_dropoff_id`) REFERENCES `Agencies` (`agency_id`);

ALTER TABLE `Payments` ADD FOREIGN KEY (`rental_id`) REFERENCES `Rentals` (`rental_id`);

ALTER TABLE `CustomerSupport` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);
