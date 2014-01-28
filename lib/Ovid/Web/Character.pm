package Ovid::Web::Character;

use strict;
use warnings;
use Plack::Builder;
use Plack::Request;
use Template::Tiny;
use List::Util 'sum';
use HTML::Entities 'encode_entities';
use Ovid::Exporter qw( psgi_app );

sub psgi_app {
    return builder {
        mount '/' => sub {
            my $env     = shift;
            my $request = Plack::Request->new($env);
            if ( '/character' eq $request->path ) {
                my $template = character_template();
                my $content;
                Template::Tiny->new->process( \$template, {}, \$content );
                my $response = $request->new_response(200);
                $response->content_type('text/html');
                $response->content($content);
                return $response->finalize;
            }
            elsif ( '/' ne $request->path ) {
                return $request->new_response(404)->finalize;
            }
            else {
                my $template = character_display();
                my $content;
                if ( $request->param ) {
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
                    my %character = map {
                        $_ => sum( map { 1 + int( rand(10) ) } 1 .. 3 )
                    } qw/strength intelligence health/;

                    foreach my $attribute (qw/name profession birthplace/) {
                        if ( my $value = $request->param($attribute) ) {
                            if ( my $adj
                                = $adjustments_for{$attribute}{$value} )
                            {
                                while ( my ( $stat, $adjustment )
                                    = each %$adj )
                                {
                                    $character{$stat} += $adjustment;
                                }
                            }
                            $character{$attribute}
                              = encode_entities(
                                $label_for{$attribute}{$value} || $value );
                        }
                        else {
                            push @errors => "\U$attribute is required";
                        }
                    }
                    if ( 'redshirt' eq $request->param('profession') ) {
                        $character{health} = 1;
                    }
                    $template = character_template() if @errors;
                    Template::Tiny->new->process(
                        \$template,
                        { character => \%character, errors => \@errors },
                        \$content
                    );
                }
                else {
                    Template::Tiny->new->process(
                        \$template,
                        { no_character_found => 1 },
                        \$content
                    );
                }
                my $response = $request->new_response(200);
                $response->content_type('text/html');
                $response->content($content);
                return $response->finalize;
            }
        };
    };
}

sub character_template {
    return <<'END';
<html>
  <head><title>Character Generation</title></head>
  <body>
    <fieldset>
      <legend>Create your character</legend>
[% FOREACH error IN errors %]
      <p style="color:red; font-weight:bold">[% error %]</p>
[% END %]
      <form action="/" method="POST" name="awesome">
        <table>
          <tr><td>Name</td>
            <td>
              <input type="text" name="name" 
                value="[% character.name %]" />
            </td>
          </tr>
          <tr>
            <td>Profession</td>
            <td>
              <select name="profession">
                <option value="programmer">Programmer</option>
                <option value="pilot">Starship Pilot</option>
                <option value="redshirt">Security Officer</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Birth place</td>
            <td>Earth     <input type="radio" name="birthplace" value="earth" /> |
                Mars      <input type="radio" name="birthplace" value="mars" /> |
                Vat 3-5LX <input type="radio" name="birthplace" value="vat" />
            </td>
          </tr>
        </table>
        <div align="center">
          <input type="submit" value="Submit" />
        </div>
      </form>
    </fieldset>
  </body>
</html>
END
}

sub character_display {
    return <<'END';
<html>
  <head><title>The Awesome "This does nothing!" Game</title></head>
  <body>
    <fieldset>
[% IF no_character_found %]
      <legend>Create your character</legend>
      <p>
        <a href="/character">Click here to create a character</a>
      </p>
[% ELSE %]
      <legend>Character Stats</legend>
      <table style="border-spacing:5px;">
        <tr><td>Name</td>        
            <td>[% character.name %]</td></tr>
        <tr><td>Profession</td>  
            <td>[% character.profession %]</td></tr>
        <tr><td>Birth place</td> 
            <td>[% character.birthplace %]</td></tr>
        <tr><td>Strength</td>    
            <td>[% character.strength %]</td></tr>
        <tr><td>Intelligence</td>
            <td>[% character.intelligence %]</td></tr>
        <tr><td>Health</td>      
            <td>[% character.health %]</td></tr>
      </table>
      <p>
        <a href="/character">
          Click here to generate another character.
        </a>
      </p>
[% END %]
    </fieldset>
  </body>
</html>
END
}

1;
