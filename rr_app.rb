require 'singleton'
require 'sqlite3'
require './chef'
require './restaurant'
require './review'
require './critic'

class RestaurantDatabase < SQLite3::Database
	include Singleton

	def initialize
		super("restaurant.db")
		self.results_as_hash = true
		self.type_translation = true
	end
end

DB ||= RestaurantDatabase.instance

