class ReadMessagesScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM messages WHERE (messages.sender_id = 1 AND messages.is_deleted_by_sender = 0) ORDER BY created_at;

      SELECT * FROM users WHERE (users.id = 2)
    }
  end

end