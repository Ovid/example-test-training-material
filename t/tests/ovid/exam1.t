use strict;
use warnings;

use Test::More;
use Test::Fatal;

use Ovid::Exam1 ':all';

# Note: There are plenty of ways of writing these tests (and the code). What
# is below is, in a number of ways, not the best strategy, but it's mostly
# clear. If you have reasonable tests, don't worry too much if they look
# different from what we have below.

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

# This one is problematic. It's *hard* to test randomness, so instead, we go
# with the simple route and assert that all values are in expected ranges.
# However, how do we test that the *distribution* of values is accurate?
# Rolling a six-sided die 100 times and having it roll 2 for 98 times suggests
# that the roll is not fair. But what if it comes up 30 times? Is that fair?
# We can use a chi-square test for this, but that's beyond the scope of this
# course.
my $range = join '|' => 1 .. 6;
$range = qr/^$range$/;

for ( 1 .. 10 ) {
    like roll_dice(), $range,
      'Default roll_dice() should return a value between 1 and 6, inclusive';
    like roll_dice( { times => -1 } ), $range,
      '... or if we specify a negative times to roll the dice';
    like roll_dice( { sides => -1 } ), $range,
      '... or if we specify negative sides';
}

$range = join '|' => 4 .. 80;
$range = qr/^$range$/;
my @bad_results;

# having so many tests for roll_dice() was annoying, so let's make it a single
# test because conceptually, it is. We'll explore more of this in later
# lessons.
for ( 1 .. 10000 ) {
    my $result = roll_dice( { sides => 20, times => 4 } );
    unless ( $result =~ $range ) {
        push @bad_results => $result;
    }
}

sub uniq (@) {
    my %seen = ();
    grep { not $seen{$_}++ } @_;
}
if (@bad_results) {
    my $bad_results = join ', ' => uniq @bad_results;
    fail("Rolling a 20 sided die 4 times didn't always work: $bad_results");
}
else {
    pass("Rolling a 20 sided die 4 times worked");
}

done_testing;
