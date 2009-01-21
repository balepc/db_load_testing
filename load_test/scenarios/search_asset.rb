class SearchAssetScenario < Scenario
  
  def query
    %Q{
      SELECT * FROM assets 
        left outer join users on users.id = assets.user_id
        left outer join projects on projects.id = assets.project_id
        left outer join ideas on ideas.id = assets.idea_id
        where (assets.name like '%Asse%') AND (assets.comments_count > 0) AND (assets.mode in (1,2,3))
        order by assets.user_id, assets.id
    }
  end
  
  def name
    "Scenario #7: Search asset"
  end

end