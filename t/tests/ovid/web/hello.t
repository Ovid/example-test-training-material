use Test::More;

use Ovid::Web::Hello 'psgi_app';
use Test::WWW::Mechanize::PSGI;

my $mech = Test::WWW::Mechanize::PSGI->new( app => psgi_app() );
$mech->get_ok( '/', 'We can fetch "/"' );
$mech->title_is( 'Hello, World!',
    '... and it should have the correct title' );
$mech->page_links_ok('... and all links on the page should be valid');
$mech->get_ok( '/style.css', 'We can fetch our CSS' );
$mech->content_like(
    qr/background-color/,
    '... and it should look reasonable'
);
$mech->get('/bad_link');
is $mech->status, 404, 'Fetching unknown links should return a 404';

done_testing;
