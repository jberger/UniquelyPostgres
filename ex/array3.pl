use Mojo::Base -strict; use Mojo::Pg; use Mojo::Util 'dumper';

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_file('ex/array.sql')->migrate;

my $tags = ['history'];
my $sql = 'SELECT * FROM books WHERE tags && ?';
print dumper $pg->db->query($sql, $tags)->hashes;

