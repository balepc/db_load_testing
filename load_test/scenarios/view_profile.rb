class ViewProfileScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM users WHERE (users.id = 1) LIMIT 1;

      SELECT * FROM profiles WHERE (profiles.user_id = 1) LIMIT 1;

      SELECT users.id FROM users 
      INNER JOIN friendships ON users.id = friendships.friend_id 
      WHERE (users.id = 1) AND ((friendships.user_id = 2)) LIMIT 1;

      SELECT * FROM assets WHERE (assets.user_id = 1) ORDER BY assets.created_at desc LIMIT 0, 15
    }
  end
  
  def name
    "Scenario #8: View profile"
  end

end