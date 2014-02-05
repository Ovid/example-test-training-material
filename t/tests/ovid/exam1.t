use lib 't/lib';
use Test::Most;
use Test::Fatal;
use Ovid::Tests;

use Ovid::Exam1 ':all';

is max(qw/3 7 8 2 -1/), 8,  'max() should return the max of its arguments';
is min(qw/3 7 8 2 -1/), -1, 'min() should return the min of its arguments';

my $result = reduce { $_[0] + $_[1] } qw/1 2 3/;
is $result, 6, 'reduce() can properly reduce a list of numbers';

$result = reduce { $_[0] * $_[1] } qw/4 5 2 4/;
is $result, 160, '... and works with multiplying';

$result = reduce { $_[0] * $_[1] } qw/10/;
is $result, 10, '... and can work with a single number';

my @empty;
$result = reduce { $_[0] * $_[1] } @empty;
is $result, undef, '... or even an empty list';

for ( 1 .. 10 ) {
    in_range_ok roll_dice(), 1, 6,
      'Default roll_dice() should return a value between 1 and 6, inclusive';
    in_range_ok roll_dice( { times => -1 } ), 1, 6,
      '... or if we specify a negative times to roll the dice';

	# test name deliberately omitted
    in_range_ok roll_dice( { sides => -1 } ), 1, 6;
}

done_testing;
