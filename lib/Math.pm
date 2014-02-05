use strict;
use warnings;

package Math;

sub sum {
    my @numbers = @_;
    my $sum = 0;
    $sum += $_ foreach @numbers;
    return $sum;
}

1;
