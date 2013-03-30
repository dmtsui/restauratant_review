require './model'
require 'debugger'
class Chef < Model
	attr_accessor :first_name, :last_name, :mentor

	COLUMNS = ['first_name','last_name','mentor']
	TABLE = 'chefs'

	def initialize(options = {})
		@id = options['id']
		@first_name = options['first_name']
		@last_name = options['last_name']
		@mentor = options['mentor'] || nil
	end

	def proteges
		Chef.multi_query(<<-SQL, id)
			SELECT *
			  FROM chefs
			 WHERE mentor = ?
		SQL
	end

	def num_proteges
		proteges.count
	end	

	def co_workers
		Chef.multi_query(<<-SQL, id)
			Select c.*
			FROM chefs c JOIN chef_tenures ct
			  ON c.id = ct.chef_id
			JOIN 
			(SELECT chef_id, restaurant_id, julianday(start_date) AS start,			
			   	COALESCE(julianday(end_date),julianday()) AS end
			   		FROM chef_tenures
			  	   WHERE chef_id = ?) as current
			  ON ct.restaurant_id = current.restaurant_id
		   WHERE c.id != current.chef_id
			 AND ((julianday(ct.start_date) BETWEEN current.start AND current.end)
			  	 OR			  	 
			  	 (COALESCE(julianday(ct.end_date),julianday()) BETWEEN current.start AND current.end))
		SQL
	end

	def reviews
		Review.multi_query(<<-SQL, id)
			SELECT rr.*
			  FROM chef_tenures ct JOIN restaurants r
			    ON ct.restaurant_id = r.id
			  JOIN restaurant_reviews rr
			  	ON rr.restaurant_id = r.id
			 WHERE ct.chef_id = ?
			   AND ct.is_head_chef = 1
		SQL
	end

	def save
		super(first_name, last_name, mentor)
		self
	end
		
	def to_s
		"<Chef ##{id} #{first_name} #{last_name}>"
	end

end