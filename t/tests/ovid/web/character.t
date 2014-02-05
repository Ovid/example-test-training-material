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
$mech->title_is( 'Character Generation', '...  and have the correct title' );
$mech->content_like(
    qr/Create your character/,
    '... and the content should look reasonable'
);
$mech->submit_form_ok(
    {   form_name => 'awesome',
        fields    => {
            name       => 'Bob',
            profession => 'pilot',
        },
    },
    '... and we should be able to submit the form'
);
$mech->content_like(
    qr/BIRTHPLACE IS REQUIRED/,
    '... but we should get an error if missed a field'
);
$mech->submit_form_ok(
    {   form_name => 'awesome',
        fields    => {
            name       => 'Bob',
            profession => 'pilot',
            birthplace => 'earth',
        },
    },
    'We should be able to resubmit the form'
);
$mech->content_like( qr/Character Stats/,    '... and get to a stats page' );
$mech->content_like( qr/Name.*Bob/,          '... and see the name' );
$mech->content_like( qr/Profession.*Pilot/,  '... and the profession' );
$mech->content_like( qr/Birth place.*Earth/, '... and the birth place' );
$mech->content_like( qr/Strength.*\d+/, '... and the generated strength' );
$mech->content_like( qr/Intelligence.*\d+/,
    '... and the generated intelligence' );
$mech->content_like( qr/Health.*\d+/, '... and the generated health' );

done_testing;
