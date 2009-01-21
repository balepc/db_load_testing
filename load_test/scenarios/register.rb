class RegisterScenario < Scenario
  
  def query
    %Q{
      INSERT INTO users(login) VALUES (UUID())
    }
  end
  
  def name
    "Scenario #6: Register"
  end

end

