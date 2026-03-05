WITH raw_data AS (
    SELECT * FROM {{ source('nba_raw_data', 'RAW_BOX_SCORES') }}
)

SELECT
    -- 1. Clean up the IDs
    game_id,
    
    -- 2. Convert that timestamp we saw earlier into a clean DATE
    CAST(game_date AS DATE) AS game_date,
    
    -- 3. Standardize column names (no more 'pts_home')
    team_abbreviation_home AS home_team,
    pts_home AS home_team_points,
    
    team_abbreviation_away AS away_team,
    pts_away AS away_team_points,
    
    -- 4. Create a "Logic" column: Who won?
    CASE 
        WHEN pts_home > pts_away THEN 'Home Win'
        ELSE 'Away Win'
    END AS game_result

FROM raw_data