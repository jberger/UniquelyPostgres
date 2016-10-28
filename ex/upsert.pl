use Mojolicious::Lite; use Mojo::Pg;
use Data::UUID;

app->secrets(['notsosecret']);

helper pg => sub {
  state $pg = Mojo::Pg->new('postgresql://test:test@/test');
};
app->pg->migrations->from_data->migrate;

helper sid => sub {
  return shift->session->{sid} ||= Data::UUID->new->create_str;
};

helper get_session => sub {
  my $c = shift;
  return $c->pg->db->query(<<'  SQL', $c->sid)->expand->hash->{payload};
    INSERT INTO session (sid)
    VALUES (?)
    ON CONFLICT (sid) DO UPDATE SET
      seen = CURRENT_TIMESTAMP
    RETURNING payload
  SQL
};

helper set_session => sub {
  my ($c, $payload) = @_;
  return !!$c->pg->db->query(<<'  SQL', $c->sid, {json => $payload})->rows;
    INSERT INTO session (sid, payload)
    VALUES (?, ?)
    ON CONFLICT (sid) DO UPDATE SET
      seen    = CURRENT_TIMESTAMP,
      payload = EXCLUDED.payload
    RETURNING payload
  SQL
};

get '/' => sub {
  my $c = shift;
  my $session = $c->get_session;
  my $accessed = ++$session->{accessed};
  $c->set_session($session);
  $c->render(text => "Accessed $accessed time(s)");
};

app->start

__DATA__

@@ migrations

-- 1 up

CREATE TABLE session (
  sid UUID PRIMARY KEY,
  seen TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  payload JSONB DEFAULT '{}'
);

-- 1 down

DROP TABLE IF EXISTS session;
