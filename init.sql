CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';


CREATE TABLE IF NOT EXISTS Flags (
  id serial,
  title varchar(100) NOT NULL UNIQUE,
  description text NOT NULL DEFAULT 'No description provided.',
  is_active boolean DEFAULT false NOT NULL,
  version int DEFAULT 1,
  rollout int NOT NULL DEFAULT 0,
  updated_at timestamp with time zone NOT NULL DEFAULT current_timestamp,
  created_at timestamp with time zone NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (id),
  constraint valid_rollout CHECK (rollout >= 0 AND rollout <= 100)
);

CREATE TABLE IF NOT EXISTS Logs (
  id serial,
  flag_id int NOT NULL,
  title varchar(100) NOT NULL,
  description varchar(100) NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Keys (
  id serial,
  sdk_key varchar(36),
  is_valid boolean DEFAULT false NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TRIGGER tg_flags_updated_at
  BEFORE UPDATE
  ON flags
  FOR EACH ROW
  EXECUTE PROCEDURE update_updated_at_column();

INSERT INTO Flags(title, description, is_active) VALUES ('LOGIN_MICROSERVICE', 'Redirects users to the login microservice', FALSE);
INSERT INTO Logs(flag_id, title, description) VALUES (1, 'LOGIN_MICROSERVICE', 'Created new flag: LOGIN_MICROSERVICE');