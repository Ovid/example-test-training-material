use strict;
use warnings;

use Test::More;
use Test::Fatal;
use Ovid::Math qw/sum average/;

is sum( 1, 2, 3 ), 6, 'sum() should sum its numeric args';
ok !defined sum(), '... and should return undef if no args';

is average(1..10), 5.5,
	'The average of the integers 1 through 10 should be 5.5';

my $average;
like exception { $average = average() },
    qr/Illegal division by zero/,
	'average of an empty list should die';
is $average, undef, '... and it should return undef';

done_testing;
