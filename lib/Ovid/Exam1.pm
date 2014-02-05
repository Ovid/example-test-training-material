package Ovid::Exam1;

use strict;
use warnings;
use Ovid::Exporter qw(reduce min max roll_dice);

# the forward declaration is necessary to ensure that the the parser
# correction interprets the first argument to the reduce() function in min()
# as a coderef and not a hashref. You're not necessarily expected to know
# this and so long as your test pass, all is well.
sub reduce(&@);

sub min {
    my $min = $_[0];
    foreach my $number (@_) {
        $min = $number if $min > $number;
    }
    return $min;
}

sub max {
    # writing this in a different style from min() to show different ways of
    # approaching a problem.
    return reduce { $_[0] > $_[1] ? $_[0] : $_[1] } @_;
}

sub reduce(&@) {
    my $subref = shift;
    my $result = shift;
    $result = $subref->( $result, $_ ) foreach @_;
    return $result;
}

sub roll_dice {
    my $arg_for = shift;

    my $sides = $arg_for->{sides} || 6;
    my $times = $arg_for->{times} || 1;

    # we could have also chosen to croak() or throw an exception here
    $sides = 6 if $sides < 2;
    $times = 1 if $times < 1;

    return reduce(
        sub { $_[0] + $_[1] },
        map { 1 + int rand $sides } 1 .. $times
    );
}

1;

__END__

=head1 NAME

Ovid::Exam1 - The exam for the first part of our testing class

=head1 SUBROUTINES

All subroutines are exportable, or you may export all with:

    use Ovid::Exam1 ':all';

=head2 C<min>

    my $min = min(@list);

This subroutine exists, but the body is empty.

B<Your task>: You must write a function to return the smallest number in the
argument list and write tests to validate that it works.

=head2 C<max>

    my $min = min(@list);

This subroutine exists, but the body is empty.

B<Your task>: You must write a function to return the largest number in the
argument list and write tests to validate that it works.

=head2 C<reduce>

This function applies a code reference to the argument list that follows. It
works like this:

    # $sum is 6
    my $sum = reduce { $_[0] + $_[1] } qw/1 2 3/;

    # $product is 160
    my @numbers = ( 4, 5, 2, 4 );
    my $product = reduce { $_[0] + $_[1] } @numbers;

Is uses a prototype to allow the subroutine to be the first argument, even
without the C<sub> keyword. Note the lack of comma after the sub body. The
call is equivalent to this:

    my $product = reduce sub { $_[0] + $_[1] }, qw/4 5 2 4/;

B<Your task>: Write tests for C<reduce> and ask yourself how you could break
this code.

=head2 C<roll_dice>

B<Your task>: Figure out what this function does and write tests to verify
that it does it. What happens if you pass negative numbers?
