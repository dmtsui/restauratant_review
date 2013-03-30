require './model'

class Critic < Model
	attr_accessor :screen_name

	COLUMNS = ['screen_name']
	TABLE = 'critics'

	def initialize(options = {})
		@id = options['id']
		@screen_name = options['screen_name']
	end

	def reviews
		Review.multi_query(<<-SQL, id)
			SELECT *
			  FROM restaurant_reviews
			 WHERE critic_id = ?
		SQL
	end

	def average_review_score
		all_scores = reviews.map {|review| review.score}
		(all_scores.inject(0){|sum,i| sum+i} / all_scores.count) || 0
	end

	def unreviewed_restaurants
		Restaurant.multi_query( <<-SQL, id)
			SELECT DISTINCT r.*
			  FROM restaurants r
			 WHERE r.id NOT IN (SELECT a.id
			   					  FROM restaurants a JOIN restaurant_reviews bb
			   					    ON a.id == bb.restaurant_id
			   					 WHERE bb.critic_id == ?)
		SQL
	end

	def save
		super(screen_name)
		self
	end

	def to_s
		"<Critic #{screen_name}>"
	end

end