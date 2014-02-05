use strict;
use warnings;

use Test::More tests => 2;
use Math 'sum';

is sum( 1, 2, 3 ), 6, 'sum() should sum its numeric args';
ok !defined sum(), '... and should return undef if no args';
