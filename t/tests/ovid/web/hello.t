use Test::More;

use Ovid::Web::Hello 'psgi_app';
use Test::WWW::Mechanize::PSGI;

my $mech = Test::WWW::Mechanize::PSGI->new( app => psgi_app() );
$mech->get_ok( '/', 'We can fetch "/"' );
diag $mech->dump_headers;

fail(<<'END');

	You'll want to read this to see what test methods you can use:

		perldoc Test::WWW::Mechanize

	Write tests to verify:

	1. That the page title is OK.
	2. That we can fetch the CSS.
	3. That URLs we don't expect return a status of 404
	4. Anything else you can think of.
END

done_testing;
