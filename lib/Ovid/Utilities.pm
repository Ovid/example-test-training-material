package Ovid::Utilities;

use strict;
use warnings;
use Term::ANSIColor;
use Ovid::Exporter qw(red green);

sub red   { color('red') . shift . color('reset') }
sub green { color('green') . shift . color('reset') }

1;
