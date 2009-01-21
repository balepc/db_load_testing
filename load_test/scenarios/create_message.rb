class CreateMessageScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM users WHERE (users.id = 1);

      INSERT INTO messages (user_id, sender_id, body) VALUES((SELECT MAX(id) FROM users), (SELECT MAX(id) FROM users)-1, 'Hello, friend!');

      UPDATE users SET unread_messages_count = unread_messages_count + 1 WHERE id = 2
    }
  end
  
  def name
    "Scenario #2: Create message"
  end

end