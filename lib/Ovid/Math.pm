use strict;
use warnings;

package Ovid::Math;

use base 'Exporter';

our @EXPORT_OK = qw(sum);

sub sum {
    my @numbers = @_;
    return unless @numbers;
    my $sum = 0;
    $sum += $_ foreach @numbers;
    return $sum;
}

1;
