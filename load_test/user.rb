require 'connection/connection_proxy'
require 'connection/balanced_connection_proxy'
require 'scenarios_pool'

class User
  
  AVG_SCENARIOS_PER_SESSION = 3
  
  attr_accessor :proxy, :name
  
  def initialize
#    self.proxy = ConnectionProxy.new
    self.proxy = BalancedConnectionProxy.new
    self.name  = "User_#{Time.now.to_i}"
  rescue Mysql::Error
    @failed = true
  end
  
  def do_some_work
    if @failed
      return {:failures => 1}
    end
    0.upto(AVG_SCENARIOS_PER_SESSION) do
      scenario = ScenariosPool.get_scenario
      scenario.execute(self.proxy)
#      puts "User #{self.name} executed #{scenario.name}"
    end
    self.proxy.summary
  end
  
end