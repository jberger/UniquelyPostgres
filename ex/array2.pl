use Mojo::Base -strict; use Mojo::Pg; use Mojo::Util 'dumper';

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_file('ex/array.sql')->migrate;

my $titles = ['Game Change', 'Primary Colors'];
my $sql = 'SELECT * FROM books WHERE title = ANY(?)';
print dumper $pg->db->query($sql, $titles)->hashes;

