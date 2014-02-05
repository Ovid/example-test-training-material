use strict;
use warnings;

package Ovid::Web::Hello;
use Ovid::Exporter qw( hello style );

sub hello {
    return sub {
        my $env = shift;
        unless ( '/' eq $env->{PATH_INFO} ) {
            return _not_found();
        }
        my $html = <<'END';
<html>
  <head>
    <link rel="stylesheet" href="/style.css">
    <title>Hello, World!</title>
  </head>
  <body>
    <p>Hello, World!</p>
  </body>
</html>
END
        return [
            200,
            [ 'Content-Type' => 'text/html' ],
            [$html],
        ];
    };
}

sub style {
    return sub {
        my $css = <<'END';
body { background-color: black }
p    { color: white }
END
        return [
            200,
            [ 'Content-Type' => 'text/css' ],
            [$css],
        ];
    };
}

sub _not_found {
    return [
        404,
        [ 'Content-Type' => 'text/plain' ],
        ['I feel so lonely. Where am I?'],
    ];
}

1;
