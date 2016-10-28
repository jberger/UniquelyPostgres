use Mojo::Base -strict; use Mojo::Pg; use Mojo::Util 'dumper';

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_file('ex/materialized.sql')->migrate;

my $db = $pg->db;
my $joel = $db->query(<<'SQL', 'joel')->hash->{id};
  INSERT INTO users (name)
  VALUES (?)
  RETURNING id
SQL

sub insert_book {
  return $db->query(<<'  SQL', shift)->hash->{id};
    INSERT INTO books (title)
    VALUES (?)
    RETURNING id
  SQL
}

sub rate_book {
  $db->query(<<'  SQL', @_);
    INSERT INTO user_books (user_id, book_id, rating)
    VALUES (?, ?, ?)
  SQL
}

rate_book $joel, insert_book('A Game of Thones'), 10;
rate_book $joel, insert_book(q[All the President's Men]), 8;
rate_book $joel, insert_book('The Stand'), 3;

$db->query('REFRESH MATERIALIZED VIEW user_book_view');

print dumper $db->query('SELECT * FROM user_book_view')->hashes;

