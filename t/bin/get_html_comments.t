use Test::Most;
use Try::Tiny;
use Capture::Tiny ':all';
require 'bin/get_html_comments.pl';

my ( $stdout, $stderr, @response ) = capture {
    try { Modulino::HTMLComments->run() } catch { warn $_ };
};
like $stderr,
  qr{\QUsage: t/bin/get_html_comments.t http://www.example.com/},
  'Need a URL to fetch comments';

( $stdout, $stderr, @response ) = capture {
    Modulino::HTMLComments->run('http://www.reddit.com');
};
like $stdout, qr/--IE6sux--/, 'Our comments should look reasonable';

fail <<'END';

    We've managed to test our script, so now we need to clean it up. Instead
    of a single 'run' method, the structure of the script should look like
    this:

        sub run          {...}
        sub get_html     {...}
        sub get_comments {...}

    Once you have enough tests in place to feel comfortable with how your
    script performs, refactor it into the above functions and write tests for
    them separately.

END

done_testing;
