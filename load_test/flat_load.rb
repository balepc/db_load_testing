require 'user'

class FlatLoad
  
  TOTAL_CONCURENT     = 50
  TOTAL_ITERATIONS    = 50
  
  attr_accessor :max_time, :min_time, :total_time, :total_queries
  
  def initialize
    self.max_time, self.total_time, self.total_queries = 0, 0, 0
    self.min_time = 999
  end
   
  def process
    threads = []
    0.upto(TOTAL_CONCURENT) do
      user = User.new
      threads << Thread.new { report_time(user.do_some_work) }
    end
    threads.each{|t| t.join}
    print_summary
  end
  
  private
  
  def report_time(summary)
    self.max_time = summary[:max_time] if summary[:max_time] > self.max_time
    self.min_time = summary[:min_time] if summary[:min_time] < self.min_time
    self.total_time += summary[:total_time]
    self.total_queries += summary[:total_queries]
  end
  
  def print_summary
    printf("Min time per request: %3f ms\n", self.min_time)
    printf("Max time per request: %3f ms\n", self.max_time)
    printf("Total requests: %d\n", self.total_queries)
    printf("Total time: %3f ms\n", self.total_time)
    
    printf("Avg time per request: %3f ms\n", self.total_time / self.total_queries)
    printf("Requests per second: %3f ms\n", 1 / (self.total_time / self.total_queries))
    
  end
  
  
end

FlatLoad.new.process