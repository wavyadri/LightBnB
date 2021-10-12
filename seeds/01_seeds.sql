-- users
INSERT INTO users (name, email, password) 
VALUES ('Edwin Gonzalez', 'edwin@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Adriana Calvo', 'adriana@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Dania Dib', 'dania@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Sam Smith', 'sam@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Cristina Calvo', 'cristina@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Peter Piper', 'peter@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.');

-- properties
INSERT INTO properties (
  owner_id,
  title, 
  description, 
  thumbnail_photo_url, 
  cover_photo_url, 
  cost_per_night, 
  parking_spaces, 
  number_of_bathrooms, 
  number_of_bedrooms, 
  country, 
  street, 
  city, 
  province, 
  post_code, 
  active
)
VALUES 
  (4, 
  'Cozy Cabin', 
  'description', 
  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F435652963950489253%2F&psig=AOvVaw1JMhtIWT05RGINyR4iMFqH&ust=1634238902361000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPDAysCMyPMCFQAAAAAdAAAAABAD',
  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.travelchannel.com%2Finterests%2Ftop-hotels%2Fphotos%2Fcozy-cabins-you-can-rent&psig=AOvVaw1JMhtIWT05RGINyR4iMFqH&ust=1634238902361000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPDAysCMyPMCFQAAAAAdAAAAABAJ',
  400,
  4,
  3,
  4,
  'Canada',
  'Side St',
  'Rossland',
  'British Columbia',
  'E51 8P6',
  true
  ),
  (5,
  'Lux Villa',
  'description',
  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.airbnb.ca%2Fibiza-spain%2Fstays%2Fluxury&psig=AOvVaw3ELvje0cqNxDHwb8gmQOdy&ust=1634239389655000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJjcvqeOyPMCFQAAAAAdAAAAABAD',
  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.airbnb.com%2Fibiza-spain%2Fstays%2Fluxury&psig=AOvVaw3ELvje0cqNxDHwb8gmQOdy&ust=1634239389655000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJjcvqeOyPMCFQAAAAAdAAAAABAI',
  600,
  4,
  6,
  6,
  'Spain',
  'Muntanya Av',
  'Ibiza',
  'Islas Baleares',
  'XX& YY1',
  false
  ),
  (6,
  'Student Living',
  'description',
  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.airbnb.ca%2Flyon-france%2Fstays&psig=AOvVaw2pD8QmSaVoR4aWUQD-PzZ9&ust=1634239620920000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPDYn5mPyPMCFQAAAAAdAAAAABAD',
  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.airbnb.ca%2Flyon-france%2Fstays&psig=AOvVaw2pD8QmSaVoR4aWUQD-PzZ9&ust=1634239620920000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPDYn5mPyPMCFQAAAAAdAAAAABAJ',
  25,
  0,
  1,
  1,
  'France',
  'Rue Jules Brunard',
  'Lyon',
  'Rhone-Alpes',
  '67000',
  true
  );

-- reservations
INSERT INTO reservations (
  start_date,
  end_date,
  property_id,
  guest_id
) 
VALUES 
  ('2020-11-30', '2020-12-03', 1, 1),
  ('2016-05-09', '2016-05-19', 2, 2),
  ('2016-09-04', '2017-03-15', 3, 3);

-- property reviews
INSERT INTO property_reviews (
  guest_id,
  property_id,
  reservation_id,
  rating,
  message
)
VALUES
  (1, 1, 1, 4, 'message'),
  (2, 2, 2, 5, 'message'),
  (3, 3, 3, 2, 'message');