require 'scenario'

require 'scenarios/create_asset'
require 'scenarios/create_message'
require 'scenarios/login'
require 'scenarios/read_messages'
require 'scenarios/read_posts'
require 'scenarios/register'
require 'scenarios/view_profile'
require 'scenarios/search_asset'

class ScenariosPool
  
  def self.get_scenario
    @@scenarios[rand(100)]
  end
  
  private
  def self.add(scenario, freq)
    0.upto(freq) { @@scenarios << scenario }
  end
  
  def self.check
    raise "Profile should be 100% totaly" unless @@scenarios.size != 100
  end
  
  @@scenarios = []
  add(RegisterScenario.new, 3)    
  add(LoginScenario.new, 5)
  add(CreateAssetScenario.new, 5)
  add(SearchAssetScenario.new, 10)
  add(ViewProfileScenario.new, 10)
  add(ReadPostsScenario.new, 17)
  add(CreateMessageScenario.new, 25)
  add(ReadMessagesScenario.new, 25)
  check 
  
end


