require 'pg'

class DatabaseConnection

  # def initialize
  #   @connection
  # end

  def self.connection
    @connection
  end

  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.query(sql)
    @connection.exec(sql)
  end


end
