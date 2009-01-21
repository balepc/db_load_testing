require 'mysql'

class ConnectionProxy
  
  attr_accessor :connection
  attr_accessor :max_time, :min_time, :total_time, :total_queries, :failures
  
  HOST = 'localhost'
  USERNAME = 'root'
  PASSWORD = 'dx87vv30'
  DATABASE = 'mtv_staging'
  
  ITERATIONS_COUNT = 10
  
  def initialize()
    self.connection = establish_connection({:host=>HOST, :username=>USERNAME, :password=>PASSWORD, :database=>DATABASE })
    self.max_time = 0.0
    self.total_time = 0.0
    self.min_time = 999.0
    self.total_queries = 0
    self.failures = 0
  end
  
  def execute_query(query)
    timer = Time.now
      
    query.split(";").each do |sql|
      self.connection.query(sql)
    end
    self.connection.query("COMMIT")
      
    report_time(Time.now - timer)
  rescue Mysql::Error
    self.failures += 1
  end
  
  def summary
    {:min_time=>self.min_time, :max_time=>self.max_time, 
      :total_time=>self.total_time, :total_queries=>self.total_queries,
      :failures=>self.failures }
  end
  
  private
  def establish_connection(conf)
    Mysql.new(conf[:host], conf[:username], conf[:password], conf[:database])
  end
  
  def report_time(time_spent)
    self.max_time = time_spent if time_spent > self.max_time
    self.min_time = time_spent if time_spent < self.min_time
    self.total_time += time_spent
    self.total_queries += 1
  end
  
end