class LoginScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM users WHERE (users.login = 'nickname') LIMIT 1
    }
  end
  
  def name
    "Scenario #3: Login"
  end

end