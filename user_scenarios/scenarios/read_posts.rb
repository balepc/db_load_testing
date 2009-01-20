class ReadPostsScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM memberships WHERE (memberships.guild_id = 1) AND (memberships.role = 'Blogmaster') ORDER BY memberships.created_at desc;

      SELECT * FROM posts WHERE (posts.guild_id = 1) ORDER BY posts.created_at desc LIMIT 0, 15
    }
  end

end





