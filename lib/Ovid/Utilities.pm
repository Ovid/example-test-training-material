package Ovid::Utilities;

use strict;
use warnings;
use Term::ANSIColor;
use Ovid::Exporter qw(red green messy);

sub red   { color('red') . shift . color('reset') }
sub green { color('green') . shift . color('reset') }

sub messy {
    warn "This goes to STDERR";
    print "ok ... this goes to STDOUT\n";
    return 42;
}

1;
