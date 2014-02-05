package Ovid::Exporter;

use strict;
use warnings;
use Carp ();
require Exporter;

sub import {
    my ( $class, @subs ) = @_;
    unless (@subs) {
        Carp::croak("$class requires a list of subs to import");
    }
    my $calling_package = caller;

    no strict 'refs';
    push @{"${calling_package}::ISA"} => 'Exporter';
    @{"${calling_package}::EXPORT_OK"} = @subs;
    %{"${calling_package}::EXPORT_TAGS"} = ( all => \@subs );
}

1;

__END__

=head1 NAME

Ovid::Exporter - simple exporting of subroutines

=head1 DESCRIPTION

This is a simple module designed to make it easy to automatically any
functions added to the import list and provides an ":all" export tag. It's not
designed to be particularly robust or production read. It just makes the
slides for the training simpler.

=head1 SYNOPSIS

    package Some::Package;

    use Ovid::Exporter qw(foo bar);

    sub foo  { }    # exported
    sub bar  { }    # exported
    sub _baz { }    # not exported

    1;

And in your calling code:

    use Some::Package qw(foo bar);
    # or
    use Some::Package ':all';
