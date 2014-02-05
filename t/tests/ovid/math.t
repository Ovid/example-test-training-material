use Test::Most;
use Test::Fatal;
use Ovid::Math ':all';

is sum( 1, 2, 3 ), 6, 'sum() should sum its numeric args';
ok !defined sum(), '... and should return undef if no args';

is average( 1 .. 10 ), 5.5,
  'The average of the integers 1 through 10 should be 5.5';

like exception { average() },
  qr/Illegal division by zero/,
  'average of an empty list should die';

ok is_odd(7),   '7 should be odd';
ok is_even(10), '10 should be even';

TODO: {
    local $TODO = 'Solving famous unsolved problems out of scope';
    ok defined( my $odd = first_odd_perfect_number() ),
      'We should receive a value for the first odd perfect number';
    ok is_odd( $odd || 0 ), '... and it should be';
}

done_testing;
