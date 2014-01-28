package Ovid::Web::Character;

use strict;
use warnings;

use Plack::Builder;
use Plack::Request;
use Template::Tiny;
use File::Slurp 'read_file';
use HTML::Entities 'encode_entities';
use Ovid::Exporter 'psgi_app';

sub psgi_app {

    # this is our controller. Note that the "model" containing the data
    # (*cough*) is moved into a generate_character() subroutine. If multiple
    # parts of your application needed that, you'd put that into a separate
    # module to make it easier to share, but we're keeping this simple.

    # Also note that the templates have been moved into a templates/
    # directory. That keeps them clean and allows other portions of the
    # application to reuse them, too.

    builder {
        mount '/' => sub {
            my $env     = shift;
            my $request = Plack::Request->new($env);
            unless ( '/' eq $request->path ) {
                return $request->new_response(404)->finalize;
            }
            my $template = 'templates/character_display.tt';
            my $content;
            if ( $request->param ) {
                my ( $character, $errors ) = generate_character($request);
                $template = 'templates/character.tt' if @$errors;
                $content = get_content(
                    $template,
                    {   character => $character,
                        errors    => $errors,
                    }
                );
            }
            else {
                $content = get_content( $template, {} );
            }
            return response( $request, $content );
        };
        mount '/character' => sub {
            my $env     = shift;
            my $request = Plack::Request->new($env);
            my $content = get_content('templates/character.tt');
            return response( $request, $content );
        };
    };
}

sub generate_character {
    my $request         = shift;
    my %adjustments_for = (
        profession => {
            programmer => {
                strength     => -3,
                intelligence => 8,
                health       => -2,
            },
            pilot    => { intelligence => 3 },
            redshirt => { strength     => 5 }
        },
        birthplace => {
            earth => {
                strength     => 2,
                intelligence => 0,
                health       => -2,
            },
            mars => { strength     => -5, health => 2 },
            vat  => { intelligence => 2,  health => -2 }
        },
    );
    my @errors;
    my %label_for = (
        profession => {
            pilot      => "Starship Pilot",
            programmer => "Programmer",
            redshirt   => "Doomed",
        },
        birthplace => {
            earth => "Earth",
            mars  => "Mars",
            vat   => "Vat 3-5LX",
        },
    );

    my %value_for
      = map { $_ => roll_dice() } qw/strength intelligence health/;

    foreach my $attribute (qw/name profession birthplace/) {
        if ( my $value = $request->param($attribute) ) {
            if ( my $adj = $adjustments_for{$attribute}{$value} ) {
                while ( my ( $stat, $adjustment ) = each %$adj ) {
                    $value_for{$stat} += $adjustment;
                }
            }
            $value_for{$attribute}
              = encode_entities( $label_for{$attribute}{$value} || $value );
        }
        else {
            push @errors => "\U$attribute is required";
        }
    }
    if ( 'redshirt' eq $request->param('profession') ) {
        $value_for{health} = 1;
    }
    return \%value_for, \@errors;
}

sub roll_dice {
    my $total = 0;
    for ( 1 .. 3 ) {
        $total += 1 + int( rand(10) );
    }
    return $total;
}

sub response {
    my ( $request, $content ) = @_;
    my $response = $request->new_response(200);
    $response->content_type('text/html');
    $response->content($content);
    return $response->finalize;
}

sub get_content {
    my ( $file, $vars ) = @_;
    $vars ||= {};
    my $template_code = read_file($file);
    my $template      = Template::Tiny->new;
    my $output;
    $template->process( \$template_code, $vars, \$output );
    return $output;
}

1;
