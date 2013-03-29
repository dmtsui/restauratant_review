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

	def save
		super(name, neighborhood, cuisine)
		self
	end

	def to_s
		"<Restaurant #{name}>"
	end

end