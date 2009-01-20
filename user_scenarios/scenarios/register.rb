class RegisterScenario < Scenario
  
  def query
    %Q{
      INSERT INTO users(login) VALUES (UUID())
    }
  end

end

