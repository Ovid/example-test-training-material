use 5.010;
use strict;
use warnings;

package Modulino::HTMLComments;
use WWW::Mechanize;
use HTML::TokeParser::Simple;
use Carp;

__PACKAGE__->run(@ARGV) unless caller();

sub run {
    my $class = shift;
    my $url   = shift @_ or die "Usage: $0 http://www.example.com/";

    my $mech = WWW::Mechanize->new;
    $mech->get($url);

    my $parser = HTML::TokeParser::Simple->new( string => $mech->content );
    while ( my $token = $parser->get_token ) {
        say $token->as_is if $token->is_comment;
    }
}

1;
