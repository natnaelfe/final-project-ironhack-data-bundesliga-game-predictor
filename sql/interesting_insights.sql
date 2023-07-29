USE final_project;

# Find the total number of games played each season:
SELECT season_x, COUNT(*) as total_games
FROM final_df
GROUP BY season_x;

# Find the total number of wins, losses, and draws for a specific team:
SELECT 
    home_team_name_x,
    SUM(CASE WHEN outcome = 'win_home' THEN 1 ELSE 0 END) as home_wins,
    SUM(CASE WHEN outcome = 'win_away' THEN 1 ELSE 0 END) as home_losses,
    SUM(CASE WHEN outcome = 'draw' THEN 1 ELSE 0 END) as home_draws
FROM 
    final_df
WHERE 
    home_team_name_x = 'SV Darmstadt 98'
GROUP BY 
    home_team_name_x

UNION ALL

SELECT 
    away_team_name_x,
    SUM(CASE WHEN outcome = 'win_away' THEN 1 ELSE 0 END) as away_wins,
    SUM(CASE WHEN outcome = 'win_home' THEN 1 ELSE 0 END) as away_losses,
    SUM(CASE WHEN outcome = 'draw' THEN 1 ELSE 0 END) as away_draws
FROM 
    final_df
WHERE 
    away_team_name_x = 'SV Darmstadt 98'
GROUP BY 
    away_team_name_x;
    
# Find the top 5 locations with the most games played:
SELECT location, COUNT(*) as total_games
FROM final_df
GROUP BY location
ORDER BY total_games DESC
LIMIT 5;

# Find the average number of goals scored by the home team and away team in each season:
SELECT 
    season_x, 
    AVG(goals_home) as avg_home_goals, 
    AVG(goals_away) as avg_away_goals
FROM 
    final_df
GROUP BY 
    season_x;

# Find the teams with the highest number of home wins in a specific season:
SELECT 
    home_team_name_x, 
    COUNT(*) as home_wins
FROM 
    final_df
WHERE 
    outcome = 'win_home' AND season_x = '2015'
GROUP BY 
    home_team_name_x
ORDER BY 
    home_wins DESC;
    
# Top Scorers
-- Home matches
SELECT home_team_name_x, AVG(goals_home) AS avg_goals_home
FROM final_df
GROUP BY home_team_name_x
ORDER BY avg_goals_home DESC;

-- Away matches
SELECT away_team_name_x, AVG(goals_away) AS avg_goals_away
FROM final_df
GROUP BY away_team_name_x
ORDER BY avg_goals_away DESC;

# Teams with most draws or losses despite having a positive goal difference
SELECT home_team_name_x, COUNT(*) AS num_unlucky_matches
FROM final_df
WHERE outcome <> 'win_home' AND hist_goal_dif > 0
GROUP BY home_team_name_x
ORDER BY num_unlucky_matches DESC;

# Similarly for away teams
SELECT away_team_name_x, COUNT(*) AS num_unlucky_matches
FROM final_df
WHERE outcome <> 'win_home' AND hist_goal_dif > 0
GROUP BY away_team_name_x
ORDER BY num_unlucky_matches DESC;

-- Average goals scored by home teams in different locations
SELECT location, AVG(goals_home) AS avg_goals_home
FROM final_df
GROUP BY location
ORDER BY avg_goals_home DESC;

-- Average goals scored by teams in different seasons
SELECT season_x, home_team_name_x, AVG(goals_home) AS avg_goals_home
FROM final_df
GROUP BY season_x, home_team_name_x
ORDER BY season_x, avg_goals_home DESC;

-- Distribution of goals scored in home matches
SELECT goals_home, COUNT(*) AS num_matches
FROM final_df
GROUP BY goals_home
ORDER BY num_matches DESC;

-- Similarly for away matches



