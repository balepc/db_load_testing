class CreateMessageScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM users WHERE (users.id = 1);

      INSERT INTO messages (user_id, sender_id, body) VALUES(1, 2, 'Hello, friend!');

      UPDATE users SET unread_messages_count = unread_messages_count + 1 WHERE id = 2
    }
  end

end