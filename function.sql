-- Функція повертає таблицю з id всіх партій гравця

DROP FUNCTION IF EXISTS get_player_games(varchar);

CREATE OR REPLACE FUNCTION get_player_games(player_id varchar(150))
	RETURNS TABLE(games_id char(8))
LANGUAGE plpgsql
AS $$
BEGIN 
	RETURN QUERY
		SELECT game_id::char(8) FROM games WHERE player_id IN (white_player, black_player);
END;
$$;