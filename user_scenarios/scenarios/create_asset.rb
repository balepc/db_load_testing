class CreateAssetScenario < Scenario
  
  def query
    %Q{
      INSERT INTO assets (user_id, name) VALUES ((SELECT MAX(id) FROM users), 'Asset_');

      UPDATE users SET assets_count = COALESCE(assets_count, 0) + 1 
      WHERE (id = 1)
    }
  end

end