-- Création de la table users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  address TEXT,
  country VARCHAR(100),
  date_of_birth DATE,
  profile_picture_url TEXT, -- URL de la photo de profil
  communication_preferences JSON, -- Préférences e-mail, SMS, push
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Création de la table cars
CREATE TABLE cars (
  id SERIAL PRIMARY KEY,
  model VARCHAR(255) NOT NULL,
  brand VARCHAR(255) NOT NULL,
  category VARCHAR(50) NOT NULL, -- Catégorie conforme à la norme ACRISS
  price_per_day DECIMAL(10, 2) NOT NULL,
  availability BOOLEAN DEFAULT TRUE,
  description TEXT,
  photos JSON, -- Liens vers les photos du véhicule
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Création de la table agencies
CREATE TABLE agencies (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address TEXT NOT NULL,
  postal_code VARCHAR(20),
  city VARCHAR(100) NOT NULL,
  country VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Création de la table reservations
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  car_id INTEGER NOT NULL,
  agency_pickup_id INTEGER NOT NULL, -- Agence de départ
  agency_return_id INTEGER NOT NULL, -- Agence de retour
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) NOT NULL, -- Statuts: en cours, annulée, terminée
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_reservation_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_reservation_car FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE,
  CONSTRAINT fk_reservation_agency_pickup FOREIGN KEY (agency_pickup_id) REFERENCES agencies (id) ON DELETE RESTRICT,
  CONSTRAINT fk_reservation_agency_return FOREIGN KEY (agency_return_id) REFERENCES agencies (id) ON DELETE RESTRICT
);

-- Création de la table payments
CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  reservation_id INTEGER NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) NOT NULL, -- Statuts: payé, en attente, remboursé
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_payment_reservation FOREIGN KEY (reservation_id) REFERENCES reservations (id) ON DELETE CASCADE
);

-- Création de la table services
CREATE TABLE services (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Création de la table reservation_services
CREATE TABLE reservation_services (
  id SERIAL PRIMARY KEY,
  reservation_id INTEGER NOT NULL,
  service_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_reservation_services_reservation FOREIGN KEY (reservation_id) REFERENCES reservations (id) ON DELETE CASCADE,
  CONSTRAINT fk_reservation_services_service FOREIGN KEY (service_id) REFERENCES services (id) ON DELETE CASCADE
);