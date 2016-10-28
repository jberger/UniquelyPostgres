-- 1 up

CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE books (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL
);

CREATE TABLE user_books (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users ON DELETE CASCADE,
  book_id BIGINT REFERENCEs books ON DELETE CASCADE,
  rating INT CHECK (rating >= 0) CHECK (rating <= 10)
);

CREATE MATERIALIZED VIEW user_book_view AS
SELECT
  users.name,
  array_agg (
    books.title ORDER BY user_books.rating DESC
  ) AS favorite_books
FROM users
LEFT JOIN user_books ON users.id=user_books.user_id
LEFT JOIN books ON user_books.book_id=books.id
WHERE user_books.rating >= 7
GROUP BY users.name
WITH NO DATA;

-- 1 down

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS user_books CASCADE;
DROP MATERIALIZED VIEW IF EXISTS user_book_view CASCADE;

