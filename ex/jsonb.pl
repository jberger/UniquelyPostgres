use Mojo::Base -strict; use Mojo::Pg;

my $pg = Mojo::Pg->new('postgresql://test:test@/test');
$pg->migrations->from_data->migrate;

sub update_report {
  my $report = shift;
  my $result = $pg->db->query(<<'  SQL', {json => $report})->hash || {};
    INSERT INTO reports (title, data)
    SELECT $1::JSONB->>'title', $1
    WHERE COALESCE((
      SELECT data <> $1
      FROM reports
      WHERE title = $1::JSONB->>'title'
      ORDER BY ts DESC
      LIMIT 1
    ), 't') 
    RETURNING jsonb_pretty(data) AS formatted;
  SQL
  return $result->{formatted} || '';
}

print update_report {
  title => 'myreport',
  stock_price => '14',
};

__DATA__

@@ migrations

-- 1 up

CREATE TABLE reports (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data JSONB NOT NULL DEFAULT '{}'
);
INSERT INTO reports (title) VALUES ('myreport');

-- 1 down

DROP TABLE IF EXISTS reports;

