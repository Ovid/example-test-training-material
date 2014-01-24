use 5.010;
use WWW::Mechanize;
use HTML::TokeParser::Simple;

my $url = shift @ARGV or die "Usage: $0 http://www.example.com/";

my $mech = WWW::Mechanize->new;
$mech->get($url);

my $parser = HTML::TokeParser::Simple->new( string => $mech->content );
while ( my $token = $parser->get_token ) {
    say $token->as_is if $token->is_comment;
}
