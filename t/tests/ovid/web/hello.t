use Test::More;

use Ovid::Web::Hello 'psgi_app';
use Test::WWW::Mechanize::PSGI;

my $mech = Test::WWW::Mechanize::PSGI->new( app => psgi_app() );
$mech->get_ok( '/', 'We can fetch "/"' );
diag $mech->dump_headers;

done_testing;
