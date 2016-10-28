-- 1 up

CREATE TABLE books (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}'
);
INSERT INTO books (title, tags) VALUES
('Primary Colors', '{politics, history}'),
('Game Change', '{politics, history}'),
('The Big Short', '{finance, history}'),
('A Game of Thrones', '{fantasy, magic}');

-- 1 down

DROP TABLE IF EXISTS books;

