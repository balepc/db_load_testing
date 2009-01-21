require 'user'

class FlatLoad
  
#  TOTAL_CONCURENT     = 10
  TOTAL_ITERATIONS    = 10
  WARM_UP_ITERATIONS  = 100
  
  attr_accessor :max_time, :min_time, :total_time, :total_queries, :failures
  
  def initialize
    self.max_time, self.total_time, self.total_queries, self.failures = 0, 0, 0, 0
    self.min_time = 999
  end
   
  def process(concurrent)
    puts "\n\n Concurrent #{concurrent}"
    warm_up
    
    threads = []
    0.upto(TOTAL_ITERATIONS) do
      0.upto(concurrent) do
        user = User.new
        threads << Thread.new { report_time(user.do_some_work) }
      end
      sleep 1
    end
    puts "Step1"
    threads.each{|t| t.join}
    puts "Step2"
    print_summary
  end
  
  private
  
  def warm_up
    timer = Time.now
    0.upto(WARM_UP_ITERATIONS) do
      User.new.do_some_work
    end
    puts "Warmed up! #{"%3f" % (Time.now - timer)} ms\n"
  end
  
  def report_time(summary)
    self.max_time = summary[:max_time] if summary[:max_time] and summary[:max_time] > self.max_time
    self.min_time = summary[:min_time] if summary[:min_time] and summary[:min_time] < self.min_time
    self.total_time += summary[:total_time] if summary[:total_time]
    self.total_queries += summary[:total_queries] if summary[:total_queries]
    self.failures += summary[:failures] if summary[:failures]
  end
  
  def print_summary
    printf("Min time per request: %3f ms\n", self.min_time)
    printf("Max time per request: %3f ms\n", self.max_time)
    printf("Total requests: %d\n", self.total_queries)
    printf("Total time: %3f ms\n", self.total_time)
    
    printf("Avg time per request: %3f ms\n", self.total_time / self.total_queries)
    printf("Requests per second: %3f ms\n", 1 / (self.total_time / self.total_queries))
    
    printf("Total filure requests: %d \n", self.failures)
  end
  
end

FlatLoad.new.process 10
FlatLoad.new.process 30
FlatLoad.new.process 50
FlatLoad.new.process 100
FlatLoad.new.process 150
FlatLoad.new.process 250
FlatLoad.new.process 500
FlatLoad.new.process 1000
