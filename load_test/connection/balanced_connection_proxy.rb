require 'mysql'

class BalancedConnectionProxy
  
  attr_accessor :connection_read
  attr_accessor :connection_write
  
  attr_accessor :max_time, :min_time, :total_time, :total_queries, :failures
  
#  HOST = 'ec2-174-129-177-131.compute-1.amazonaws.com'
  MASTER_HOST = 'localhost'
  MASTER_USERNAME = 'root'
  MASTER_PASSWORD = 'dx87vv30'
  MASTER_DATABASE = 'mtv_staging'
  
  SLAVE_HOST = 'localhost'
  SLAVE_USERNAME = 'root'
  SLAVE_PASSWORD = 'dx87vv30'
  SLAVE_DATABASE = 'mtv_staging'
  
  ITERATIONS_COUNT = 10
  
  def initialize()
    self.connection_read = establish_connection({:host=>SLAVE_HOST, :username=>SLAVE_USERNAME, :password=>SLAVE_PASSWORD, :database=>SLAVE_DATABASE })
    self.connection_write = establish_connection({:host=>MASTER_HOST, :username=>MASTER_USERNAME, :password=>MASTER_PASSWORD, :database=>MASTER_DATABASE })
    
    self.max_time = 0.0
    self.total_time = 0.0
    self.min_time = 999.0
    self.total_queries = 0
    self.failures = 0
  end
  
  def execute_query(query)
    timer = Time.now
    
    connection = get_connection(query)
    query.split(";").each do |sql|
      connection.query(sql)
    end
    connection.query("COMMIT")
      
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
  
  def get_connection(query)
    if query.downcase.include?("insert") or query.downcase.include?('update')
      puts "write"
      self.connection_write
    else
      puts "read"
      self.connection_read
    end
  end
  
end
