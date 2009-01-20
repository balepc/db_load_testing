require 'fileutils'

class Scenario
  
  MYSQLLAMP     = "/usr/local/mysql/bin/mysqlslap"
  DB_NAME       = "mtv_development"
  DB_USER       = "root"
  DB_PASSWORD   = "dx87vv30"
  
  def execute(args)
    scenario_file_name = "#{self.class.to_s}_#{Time.now.to_i}"
    file = File.open(scenario_file_name, 'w')
    file.write(query)
    file.close
    cmd = "#{MYSQLLAMP} --create-schema=#{DB_NAME} -u #{DB_USER} --password=#{DB_PASSWORD} --query=#{scenario_file_name} --concurrency=#{args[:concurrent_users]} --iterations=#{args[:iterations]} --delimiter=\";\" --commit=#{args[:commits]}"
    result = `#{cmd}`
    FileUtils.rm(scenario_file_name)
    
    result.match(/Average number of seconds to run all queries: ([0-9.]+) seconds/)[1].to_f
  end
  
end