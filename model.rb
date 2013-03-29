require 'debugger'
class Model
	attr_reader :id

	def self.find_by_id(arg) 		
		params = DB.execute(<<-SQL, arg)[0]
			SELECT *
			  FROM #{self::TABLE}
			 WHERE id = ?
		SQL
		self.new(params)
	end

	def self.single_query(query, *args)
		params = DB.execute(query, *args)[0]
	    self.new(params)
	end

	def self.multi_query(query, *args)
		params_array = DB.execute(query, *args)
    	params_array.map {|params| self.new(params) }
	end

	def save(*params)
	    if id
	      query = <<-SQL
	        UPDATE #{self.class::TABLE}
	           SET #{self.class::COLUMNS.join(' = ?,')+" = ?"}
	         WHERE id = ?
	      SQL
	      DB.execute(query, *params, id)
	    else
	      query = <<-SQL 
	      INSERT INTO users (#{self.class::COLUMNS.join(",")} ) 
	           VALUES (#{(["?"]*self.class::COLUMNS.count).join(",")}) 
	      SQL
	      DB.execute(query, *params)
	      @id = DB.last_insert_row_id()
	    end
	end


end