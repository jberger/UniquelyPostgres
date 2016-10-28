use Mojo::Base -strict; use Mojo::Pg;

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_data->migrate;

sub insert {
  eval { $pg->db->query(<<'  SQL', @_) };
    INSERT INTO mountain (name, base, peak)
    VALUES (?, ?, ?)
  SQL
  warn $@ ? $@ : "Success!\n";
}

insert 'Everest', 17500, 29029;
insert 'Sunken', -1000, 15000;
insert 'Inverted', 29029, 17500;

__DATA__

@@ migrations

-- 1 up

CREATE TABLE mountain (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  base NUMERIC CHECK (base > 0),
  peak NUMERIC,
  CHECK (peak > base)
);

-- 1 down

DROP TABLE IF EXISTS mountain;
