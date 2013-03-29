CREATE TABLE IF NOT EXISTS chefs (
		id INTEGER PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
 last_name VARCHAR(255) NOT NULL,
	mentor INTEGER,
	UNIQUE (first_name, last_name, mentor)
);

CREATE TABLE IF NOT EXISTS restaurants (
		   id INTEGER PRIMARY KEY,
	 	 name VARCHAR(255) NOT NULL,
 neighborhood VARCHAR(255) NOT NULL,
	  cuisine VARCHAR(255) NOT NULL,

	UNIQUE(name, neighborhood, cuisine)
);

CREATE TABLE IF NOT EXISTS chef_tenures  (
		chef_id INTEGER NOT_NULL,
  restaurant_id INTEGER NOT NULL,
	 start_date DATE NOT NULL,
	   end_date DATE,
   is_head_chef INT2,

	FOREIGN KEY(chef_id) REFERENCES chefs(id),
	FOREIGN KEY(restaurant_id) REFERENCES restaurants(id)
);

CREATE TABLE IF NOT EXISTS critics (
			id INTEGER PRIMARY KEY,
   screen_name VARCHAR(255) NOT NULL,

	UNIQUE (screen_name)
);

CREATE TABLE IF NOT EXISTS restaurant_reviews (
			   id INTEGER PRIMARY KEY,
		critic_id INTEGER NOT NULL,
	restaurant_id INTEGER NOT NULL,
		   review TEXT NOT NULL,
			score INTEGER NOT NULL,
	  review_date DATE NOT NULL,

		 UNIQUE(critic_id, restaurant_id),
	FOREIGN KEY(critic_id) REFERENCES critics(id),
	FOREIGN KEY(restaurant_id) REFERENCES restaurants(id)
);

-- INSERT INTO chefs (first_name, last_name, mentor)
-- VALUES ('Ned', 'Ruggeri', NULL),
-- 	   ('Kyle', 'Lucovsky', 1),
-- 	   ('Dan', 'Tsui', 2),
-- 	   ('Anthony', 'Woo', 2),
-- 	   ('Niranjan','Ramadas', 1),
-- 	   ('Jonathan', 'Tamboer', 1);

-- INSERT INTO restaurants (name, neighborhood, cuisine)
-- VALUES ('App Academy SF','SOMA', 'Rails'),
-- 	   ('App Academy NY', 'NYC', 'Rails'),
-- 	   ('Humble Py','Downtown','Python');

-- INSERT INTO critics (screen_name)
-- VALUES ('Sloppy Joe'),
-- 	   ('Eats Anything'),
-- 	   ('Picky Duck');

-- INSERT INTO restaurant_reviews (critic_id, restaurant_id, review, score, review_date)
-- VALUES (1, 1, "Great school to go to!", 20, "2013-03-29"),
-- 	   (2, 1, "Love Ruby here!", 18, "2013-03-20"),
-- 	   (3, 1, "App Academy is awesome!", 15, "2013-02-03"),
-- 	   (2, 2, "NYC can't wait!", 15, "2013-02-05"),
-- 	   (2, 3, "This humble py sucks!", 10, "2013-01-10"),
-- 	   (3, 4, "Not bad at Hackbrite!", 14, "2013-03-14");


-- INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date, is_head_chef)
-- VALUES (1, 1, "2012-10-01", NULL, 1),
-- 	   (2, 1, "2012-10-01", NULL, 0),
-- 	   (3, 1, "2013-03-11", NULL, 0),
-- 	   (4, 1, "2013-03-11", NULL, 0),
-- 	   (5, 1, "2012-10-01", NULL, 0),
-- 	   (6, 1, "2012-10-01", "2013-05-10", 0),
-- 	   (6, 2, "2013-05-11", NULL, 1);







