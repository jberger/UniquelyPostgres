use Mojo::Base -strict; use Mojo::Pg; use Mojo::Util 'dumper';

my $pg = Mojo::Pg->new('postgresql://test:test@/test');

print dumper $pg->db->query('SELECT ?=? AS sane', 'twice', 'twice')->hash->{sane};
print dumper $pg->db->query('SELECT $1=$1 AS sane', 'ONCE')->hash->{sane};

