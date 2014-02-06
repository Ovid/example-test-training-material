use 5.010;
use strict;
use warnings;

package Modulino::HTMLComments;
use Carp;
use HTML::TokeParser::Simple;
use Net::Ping;
use WWW::Mechanize;

__PACKAGE__->run(@ARGV) unless caller();

sub run {
    my $class = shift;
    print join "\n" => $class->get_comments( $class->get_html(shift) );
}

sub get_html {
    my ( $class, $url ) = @_;
    unless ($url) {
        croak("get_html() requires a URL");
    }
    my $mech = WWW::Mechanize->new;
    $mech->get($url);
    return $mech->content;
}

sub get_comments {
    my ( $class, $html ) = @_;
    my $parser = HTML::TokeParser::Simple->new( string => $html );
    my @comments;
    while ( my $token = $parser->get_token ) {
        push @comments => $token->as_is if $token->is_comment;
    }
    return @comments;
}

sub have_internet {
    # this will hang a bit if we don't have internet
    eval "use Net::Ping::External";
    if ( my $error = $@ ) {
        my $builder = Test::Builder->new;
        $builder->note("Cannot load Net::Ping::External: $error.");
        $builder->diag(
            "Defaulting to the assumption that we have internet access");
        return 1;
    }
    else {
        my $net = Net::Ping->new("external");

        # ping Google's DNS server
        return $net->ping('8.8.8.8') ? 1 : 0;
    }
}

1;
