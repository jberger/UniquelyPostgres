use Mojolicious::Lite;

plugin 'RevealJS';

any '/' => { template => 'presentation', layout => 'revealjs' };

app->start;

__DATA__

@@ presentation.html.ep

<section>
  <h1>Uniquely Postgres</h1>
  <img src="elephant.png" style="width: 20%">
  <p>Joel Berger</p>
</section>

<section>
  <h3>Meta Slide</h3>
  <ul>
    <li>I first gave this talk at Chicago.pm on Oct 27, 2016</li>
    <li>This is the first version of the talk</li>
    <!-- <li>I updated it on March 21, 2016 for Milwaukee (Brew City) Perl Mongers</li> -->
    <li>The talk is hosted at <a href="http://jberger.github.io/UniquelyPostgres" target="_blank">http://jberger.github.io/UniquelyPostgres</a></li>
    <li>The source is available at <a href="https://github.com/jberger/UniquelyPostgres" target="_blank">https://github.com/jberger/UniquelyPostgres</a></li>
    <li>All code samples and all tests:
      <ul>
        <li>are complete and run as shown</li>
        <li>are included in the repository</li>
      </ul>
    </li>
  </ul>
</section>

<section>
  <p>This presentation uses</p>
  <ul>
    <li><a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a> 9.4-9.6</li>
    <li><a href="http://mojolicio.us" target="_blank">Mojolicious</a> with <a href="http://mojolicio.us/perldoc/Mojo/Pg" target="_blank">Mojo::Pg</a></li>
  </ul>
</section>

<section>
  <section>
    <h3>PostgreSQL is ...</h3>
    <ul>
      <li>Primarily motivated by data integrity.</li>
      <li>Has and adds lots of features that ease data integrity ...</li>
      <li>... as long as they don't hurt data integrity elsewhere.</li>
    </ul>
  </section>

  <section>
    <h3>PostgreSQL isn't ...</h3>
    <ul>
      <li>The easiest to install/quickstart</li>
      <li>Easy to deploy master/slave</li>
      <li>Really possible to deploy multi-master</li>
    </ul>
  </section>
</section>

<section>
  <h2>Features!</h2>
</section>

<section>
  <section>
    <h3>Transactional DDL</h3>
    %= include_code 'ex/ddl-1.pl'
  </section>

  <section>
    <h3>Transactional DDL</h3>
    %= include_code 'ex/ddl-2.pl'
  </section>

  <section>
    <h3>Transactional DDL</h3>
    %= include_code 'ex/ddl-3.pl'
  </section>
</section>

<section>
  <h3>Check Constraints</h3>
  %= include_code 'ex/check.pl'
</section>

<section>
  <h3>Insert Returning</h3>
  %= include_code 'ex/returning.pl'
</section>

<section>
  <section>
    <h3>Who Hasn't Done This?</h3>
    %= include_code 'ex/array1.pl'
  </section>
  <section>
    <h3>Array Types</h3>
    %= include_code 'ex/array2.pl'
  </section>
  <section>
    <h3>Array Types</h3>
    %= include_code 'ex/array.sql', language => 'sql'
  </section>
  <section>
    <h3>Array Types</h3>
    %= include_code 'ex/array3.pl'
  </section>
</section>

<section>
  <h3>$N Placeholders</h3>
  <p>Positional placeholders (not just sequential)!</p>
  %= include_code 'ex/dollar.pl'
</section>

<section>
  <h3>JSON(B) Types</h3>
  %= include_code 'ex/jsonb.pl'
</section>

<section>
  <h3>Upsert</h3>
  %= include_code 'ex/upsert.pl'
</section>

<section>
  <h3>Notify</h3>
  %= include_code 'ex/chat.pl'
</section>

<section>
  <section>
    <h3>Materialized Views</h3>
    %= include_code 'ex/materialized.sql', language => 'sql'
  </section>

  <section>
    <h3>Materialized Views</h3>
    %= include_code 'ex/materialized.pl'
  </section>
</section>

<section>
  <h3>Row-Level Locking</h3>

  <ul>
    <li>Lock rows for write or access</li>
    <li>Can skip locked rows!</li>
  </ul>
</section>

<section>
  <h2>Thanks!</h2>
</section>

