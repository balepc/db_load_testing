require 'scenario'

require 'scenarios/create_asset'
require 'scenarios/create_message'
require 'scenarios/login'
require 'scenarios/read_messages'
require 'scenarios/read_posts'
require 'scenarios/register'
require 'scenarios/view_profile'
require 'scenarios/search_asset'

class TestCase 
  
  TOTAL_CONCURENT     = 10
  TOTAL_ITERATIONS    = 100
  
  @@testing_profile = [
    [LoginScenario.new, 5],
    [RegisterScenario.new, 3],
    [CreateAssetScenario.new, 5],
    [ViewProfileScenario.new, 10],
    [CreateMessageScenario.new, 25],
    [ReadMessagesScenario.new, 25],
    [ReadPostsScenario.new, 17],
    [SearchAssetScenario.new, 10]
  ]
  
  def process
    avg_time = 0
    threads = []
    @@testing_profile.each do |scenario, freq|
      threads << Thread.new { avg_time += scenario.execute(:iterations=>TOTAL_ITERATIONS, :commits=>0, :concurrent_users=>(TOTAL_CONCURENT*freq)/100) }
    end
    threads.each{|t| t.join}
    puts "Average number of seconds to run all queries: #{avg_time/@@testing_profile.size} seconds"
  end
  
end

TestCase.new.process