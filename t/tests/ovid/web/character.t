use Test::More;

use Ovid::Web::Character 'psgi_app';
use Test::WWW::Mechanize::PSGI;

my $mech = Test::WWW::Mechanize::PSGI->new( app => psgi_app() );
$mech->get_ok( '/', 'We can fetch "/"' );
$mech->title_is(
    'The Awesome "This does nothing!" Game',
    '... and it should have the correct title'
);
$mech->page_links_ok('... and all links on the page should be valid');
$mech->get('/bad_link');
is $mech->status, 404, 'Fetching unknown links should return a 404';

$mech->get_ok( '/character', 'We should be able to get the character page' );

fail(<<'END');

	This is the refactoring exercise. To run the app, you can type

		plackup --port $port bin/character.psgi
	
	Then navigate to http://localhost:$port/ and create a game character. Look
	to see what errors you get if you omit fields.

	The code is very poorly structured. Write tests to make sure you've nailed
	down behavior and then separate the code loosely into a MVC
	(Model-View-Controller) system.

	The templates (HTML) should be in separate files that you read in.

	The character generation data should be in a separate files, but a
	separate subroutine is fine for this example. The app logic should be
	relatively small.

	This exercise will take longer than the others.
END

done_testing;
