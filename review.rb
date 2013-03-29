require './model'
class Review < Model
	attr_accessor :critic_id, :restaurant_id, :review, :score, :review_date
	
	COLUMNS = ['critic_id','restaurant_id','review','score','review_date']
	TABLE = 'restaurant_reviews'

	def initialize(options = {})
		@critic_id = options['critic_id']
		@restaurant_id = options['restaurant_id']
		@review = options['review']
		@score = options['score']
		@review_date = options['review_date']
	end

	def save
		super(critic_id, restaurant_id, review, score, review_date)
		self
	end

	def to_s
		"<Review #{review[0,20]}...>"
	end
end