use strict;
use warnings;

package Ovid::Math;

use Ovid::Exporter qw(
  average
  first_odd_perfect_number
  is_even
  is_odd
  sum
);

sub average {
    my @numbers = @_;
    no warnings 'uninitialized';

    # you could also do my $sum = sum(@numbers) || 0;
    return sum(@numbers) / @numbers;
}

sub sum {
    my @numbers = @_;
    return unless @numbers;
    my $sum = 0;
    $sum += $_ foreach @numbers;
    return $sum;
}

sub first_odd_perfect_number {
    die <<'END';
This is a famous unsolved problem in mathematics, so solve this and claim your fame.
http://mathworld.wolfram.com/OddPerfectNumber.html
END
}

sub is_odd  {
    my $number = shift;
    return $number % 2;
}
sub is_even {
    my $number = shift;
    return !is_odd($number);
}

1;
