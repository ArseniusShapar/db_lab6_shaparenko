/* Тригер відслідковує модифікацію таблиці orders та створює окрему таблицю orders_audit, в якій відображається, яка саме 
була здійснена операція (INSERT, UPDATE чи DELETE), яким користувачем, та записує час, коли відбулася дана операція */


DROP TABLE IF EXISTS players_audit;
CREATE TABLE players_audit(
	id SERIAL PRIMARY KEY,
	change_date TIMESTAMP,
	change_type varchar(10),
	user_name varchar(50) NOT NULL
);

CREATE OR REPLACE FUNCTION update_players_audit() RETURNS trigger 
LANGUAGE 'plpgsql'
AS $$
BEGIN
	INSERT INTO players_audit(change_date, change_type, user_name)
	VALUES(NOW(), 'UPDATE', USER);
	RETURN NULL;
END;
$$;

CREATE OR REPLACE FUNCTION insert_players_audit() RETURNS trigger 
LANGUAGE 'plpgsql'
AS $$
BEGIN
	INSERT INTO players_audit(change_date, change_type, user_name)
	VALUES(NOW(), 'INSERT', USER);
	RETURN NULL;
END;
$$;

CREATE OR REPLACE FUNCTION delete_players_audit() RETURNS trigger 
LANGUAGE 'plpgsql'
AS $$
BEGIN
	INSERT INTO players_audit(change_date, change_type, user_name)
	VALUES(NOW(), 'DELETE', USER);
	RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER players_update_details 
AFTER UPDATE ON players
FOR EACH ROW EXECUTE FUNCTION update_players_audit();

CREATE OR REPLACE TRIGGER players_insert_details 
AFTER INSERT ON players
FOR EACH ROW EXECUTE FUNCTION insert_players_audit();

CREATE OR REPLACE TRIGGER players_delete_details 
AFTER DELETE ON players
FOR EACH ROW EXECUTE FUNCTION delete_players_audit();