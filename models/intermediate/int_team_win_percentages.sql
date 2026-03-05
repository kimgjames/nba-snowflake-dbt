WITH games AS (
    SELECT * FROM {{ ref('stg_nba_games') }}
),

team_counts AS (
    SELECT 
        home_team AS team,
        COUNT(*) AS total_home_games,
        SUM(CASE WHEN game_result = 'Home Win' THEN 1 ELSE 0 END) AS home_wins
    FROM games
    GROUP BY 1
)

SELECT 
    team,
    total_home_games,
    home_wins,
    -- The Math: Rounding to 2 decimal places for a clean dashboard
    ROUND((home_wins / total_home_games) * 100, 2) AS home_win_pct
FROM team_counts
ORDER BY home_win_pct DESC