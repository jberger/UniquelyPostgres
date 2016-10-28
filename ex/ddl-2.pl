use Mojo::Base -strict; use Mojo::Pg; use Mojo::Util 'dumper';

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_data->migrate;

print dumper $pg->db->query('SELECT * FROM people')->hash;

__DATA__

@@ migrations

-- 1 up

CREATE TABLE people (
  id BIGSERIAL PRIMARY KEY,
  first TEXT,
  last TEXT
);

-- 1 down

DROP TABLE IF EXISTS people;

-- 2 up

ALTER TABLE people
  ALTER COLUMN first SET DATA TYPE TEXT USING first || ' ' || last,
  DROP COLUMN last;
ALTER TABLE people
  RENAME COLUMN first TO name;

