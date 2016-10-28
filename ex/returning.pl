use Mojo::Base -strict; use Mojo::Pg; use Mojo::Util 'dumper';

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_data->migrate;

print dumper $pg->db->query(<<'SQL', 'pepperoni')->hash;
  INSERT INTO pizza (request)
  VALUES (?)
  RETURNING *, TO_CHAR(created + '30m'::INTERVAL, 'HH:MI AM') AS due
SQL

__DATA__

@@ migrations

-- 1 up

CREATE TABLE pizza (
  id BIGSERIAL PRIMARY KEY,
  request TEXT NOT NULL,
  created TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 1 down

DROP TABLE IF EXISTS pizza;
