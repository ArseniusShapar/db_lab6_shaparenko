-- Функція
SELECT get_player_games('a-00');


-- Процедура
INSERT INTO players VALUES ('player_01', 1000, CURRENT_DATE, NULL);
SELECT * FROM players WHERE player_id = 'player_01';

CALL delete_no_games_players();
SELECT * FROM players WHERE player_id = 'player_01';


-- Тригер
INSERT INTO players VALUES ('player_01', 1000, CURRENT_DATE, NULL);
UPDATE players SET rating = 2000 WHERE player_id = 'player_01';
DELETE FROM players WHERE player_id = 'player_01';

SELECT * FROM players_audit;