use Test::Most;
use Try::Tiny;
use Capture::Tiny ':all';
require 'bin/get_html_comments.pl';

SKIP: {
    skip 'No internet access'
      unless Modulino::HTMLComments->have_internet;
    my ( $stdout, $stderr, @response ) = capture {
        try { Modulino::HTMLComments->run() } catch { warn $_ };
    };
    like $stderr,
      qr{\Qget_html() requires a URL },
      'Need a URL to fetch comments';

    ( $stdout, $stderr, @response ) = capture {
        Modulino::HTMLComments->run('http://www.reddit.com');
    };
    like $stdout, qr/--IE6sux--/, 'Our comments should look reasonable';

    # this test is fragile because it requires that reddit be up, but it's for
    # example purposes
    my $html = Modulino::HTMLComments->get_html('http://www.reddit.com');
    like $html, qr{<title>.*</title>}s, 'We should be able to fetch HTML';
}

my $html = <<'END';
<html>
    <head><title>This is a title page</title></head>
    <body>
        <p>This is text</p>
        <!-- this is a comment -->
        <p>This is more text</p>
        <!-- this is another comment -->
    </body>
</html>
END

my @comments = Modulino::HTMLComments->get_comments($html);
eq_or_diff \@comments,
  [ '<!-- this is a comment -->', '<!-- this is another comment -->' ],
  'get_comments() should return HTML comments';

done_testing;
