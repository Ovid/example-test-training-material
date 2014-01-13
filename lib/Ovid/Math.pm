use strict;
use warnings;

package Ovid::Math;

use base 'Exporter';

our @EXPORT_OK = qw(sum average);

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

1;
