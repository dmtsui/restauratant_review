require './model.rb'

class Restaurant < Model
	attr_accessor :name, :neighborhood, :cuisine
	
	COLUMNS = ['name','neighborhood','cuisine']
	TABLE = 'restaurants'

	def self.by_neighborhood(hood)
		multi_query(<<-SQL , hood)
			SELECT *
			  FROM restaurants
			 WHERE neighborhood = ?
		SQL
	end

	def initialize(options = {})
		@id = options['id']
		@name = options['name']
		@neighborhood = options['neighborhood']
		@cuisine = options['cuisine']
	end

	def self.top_restaurants(n)
		multi_query(<<-SQL, n)
			SELECT r.*
			  FROM restaurants r JOIN restaurant_reviews rr
			    ON r.id = rr.restaurant_id
			 GROUP BY r.id
			 ORDER BY AVG(rr.score) DESC
			 LIMIT ?
		SQL
	end

	def self.highly_reviewed_restaurants(min)
		multi_query(<<-SQL, min)
			SELECT r.*
			  FROM restaurants r JOIN restaurant_reviews rr
			    ON r.id = rr.restaurant_id
			 GROUP BY r.id
			HAVING COUNT(rr.score) >= ?		
		SQL
	end

	def save
		super(name, neighborhood, cuisine)
		self
	end

	def to_s
		"<Restaurant #{name}>"
	end

end