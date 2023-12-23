-- Процедура видаляє з таблиці всіх гравців, що не мають партій

DROP PROCEDURE IF EXISTS delete_no_games_players();

CREATE OR REPLACE PROCEDURE delete_no_games_players()
LANGUAGE plpgsql
AS $$
BEGIN 
	DELETE FROM players WHERE (SELECT COUNT(game_id) FROM games WHERE player_id IN (white_player, black_player)) = 0;
END;
$$;