{{ config(materialized='table') }}

SELECT
    team,
    total_home_games,
    home_wins,
    home_win_pct,
    -- Senior Logic: Add a "Status" flag for easier reporting
    CASE 
        WHEN home_win_pct >= 60 THEN 'Elite Home Team'
        WHEN home_win_pct >= 40 THEN 'Average Home Team'
        ELSE 'Struggling Home Team'
    END AS team_status
FROM {{ ref('int_team_win_percentages') }}