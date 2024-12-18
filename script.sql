
Table users {
  id integer [primary key]
  username varchar
  email varchar
  password varchar
  phone_number varchar
  address text
  country varchar
  date_of_birth date
  profile_picture_url text [note: 'URL de la photo de profil']
  communication_preferences json [note: 'Préférences e-mail, SMS, push']
  created_at timestamp
}

Table cars {
  id integer [primary key]
  model varchar
  brand varchar
  category varchar [note: 'Catégorie conforme à la norme ACRISS']
  price_per_day decimal
  availability BOOLEAN
  description text
  photos json [note: 'Liens vers les photos du véhicule']
  created_at timestamp
}

Table agencies {
  id integer [primary key]
  name varchar
  address text
  postal_code varchar
  city varchar
  country varchar
  phone_number varchar
  created_at timestamp
}

Table reservations {
  id integer [primary key]
  user_id integer
  car_id integer
  agency_pickup_id integer [note: 'Agence de départ']
  agency_return_id integer [note: 'Agence de retour']
  start_date timestamp
  end_date timestamp
  total_price decimal
  status varchar [note: 'Statuts: en cours, annulée, terminée']
  created_at timestamp

  CONSTRAINT fk_reservation_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_reservation_car FOREIGN KEY (car_id) REFERENCES cars(id),
  CONSTRAINT fk_reservation_agency_pickup FOREIGN KEY (agency_pickup_id) REFERENCES agencies(id),
  CONSTRAINT fk_reservation_agency_return FOREIGN KEY (agency_return_id) REFERENCES agencies(id)
}

Table payments {
  id integer [primary key]
  reservation_id integer
  payment_date timestamp
  amount decimal
  status varchar [note: 'Statuts: payé, en attente, remboursé']
  created_at timestamp

  CONSTRAINT fk_payment_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id)
}

Table services {
  id integer [primary key]
  name varchar
  description text
  price decimal
  created_at timestamp
}

Table reservation_services {
  id integer [primary key]
  reservation_id integer
  service_id integer
  created_at timestamp

  CONSTRAINT fk_reservation_services_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id),
  CONSTRAINT fk_reservation_services_service FOREIGN KEY (service_id) REFERENCES services(id)
}
