Table users {
  id integer [primary key]
  username varchar
  email varchar
  password varchar
  phone_number varchar
  address text
  created_at timestamp
}

Table cars {
  id integer [primary key]
  model varchar
  brand varchar
  category varchar
  price_per_day decimal
  availability BOOLEAN
  created_at timestamp
}

Table reservations {
  id integer
  user_id integer
  car_id integer
  start_date date
  end_date date
  total_price decimal
  status varchar
  created_at timestamp 
}

Table payments {
  id integer
  reservation_id integer
  payment_date timestamp
  amount decimal
  total_price decimal
  status varchar
 
}

// Relations entre les tables
Ref: reservations.user_id > users.id // Un utilisateur peut avoir plusieurs réservations
Ref: reservations.car_id > cars.id // Une voiture peut être réservée plusieurs fois
Ref: payments.reservation_id > reservations.id // Une réservation est liée à un paiement