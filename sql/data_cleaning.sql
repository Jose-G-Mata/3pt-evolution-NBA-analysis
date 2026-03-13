-- Delete all season before the incorporation of the 3-Point Line (1980) and the data from the unfinsihed season of this year (2026).
DELETE FROM team_totals WHERE season < 1980 or season > 2025;
DELETE FROM player_totals WHERE season < 1980 or season > 2025;
DELETE FROM player_season_info WHERE season < 1980 or season > 2025;

-- Delete duplicate rows when a player have multiples teams in a season and conserve the row with aggregate stats, create new table and later renamed as the original
CREATE TABLE combined_player_totals AS
SELECT * 
FROM player_totals pt
WHERE (pt.season, pt.player_id) NOT IN (
  SELECT season, player_id 
  FROM player_totals 
  WHERE abbrev IN ('2TM', '3TM', '4TM', '5TM')
)
UNION ALL
SELECT * 
FROM player_totals 
WHERE abbrev IN ('2TM', '3TM', '4TM', '5TM');

--Change NA values to 0
UPDATE player_totals
SET x3p_percent = 0
WHERE x3p_percent IS NA;
