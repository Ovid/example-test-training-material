package Ovid::DateTime::Tiny;

use strict;
use warnings;

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub now {
    my @t = localtime time;
    shift->new(
        year   => $t[5] + 1900,
        month  => $t[4] + 1,
        day    => $t[3],
        hour   => $t[2],
        minute => $t[1],
        second => $t[0],
    );
}

sub year {
    defined $_[0]->{year} ? $_[0]->{year} : 1970;
}

sub month  { $_[0]->{month}  || 1 }
sub day    { $_[0]->{day}    || 1 }
sub hour   { $_[0]->{hour}   || 0 }
sub minute { $_[0]->{minute} || 0 }
sub second { $_[0]->{second} || 0 }

sub ymdhms {
    sprintf(
        "%04u-%02u-%02uT%02u:%02u:%02u",
        $_[0]->year,
        $_[0]->month,
        $_[0]->day,
        $_[0]->hour,
        $_[0]->minute,
        $_[0]->second,
    );
}

sub from_string {
    my $string = $_[1];
    unless ( defined $string and !ref $string ) {
        Carp::croak("Did not provide a string to from_string");
    }
    unless ( $string =~ /^(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d):(\d\d)$/ ) {
        Carp::croak("Invalid time format (does not match ISO 8601)");
    }
    $_[0]->new(
        year   => $1 + 0,
        month  => $2 + 0,
        day    => $3 + 0,
        hour   => $4 + 0,
        minute => $5 + 0,
        second => $6 + 0,
    );
}

sub as_string {
    $_[0]->ymdhms;
}

sub DateTime {
    require DateTime;
    my $self = shift;
    DateTime->new(
        day       => $self->day,
        month     => $self->month,
        year      => $self->year,
        hour      => $self->hour,
        minute    => $self->minute,
        second    => $self->second,
        locale    => 'C',
        time_zone => 'floating',
        @_,
    );
}

1;

__END__

=head1 NAME

Ovid::DateTime::Tiny - A date object, with as little code as possible

=head1 SYNOPSIS

  # Create a date manually
  $christmas = Ovid::DateTime::Tiny->new(
      year   => 2006,
      month  => 12,
      day    => 25,
      hour   => 10,
      minute => 45,
      second => 0,
  );
  
  # Show the current date
  my $now = Ovid::DateTime::Tiny->now;
  print "Year   : " . $now->year   . "\n";
  print "Month  : " . $now->month  . "\n";
  print "Day    : " . $now->day    . "\n"; 
  print "Hour   : " . $now->hour   . "\n";
  print "Minute : " . $now->minute . "\n";
  print "Second : " . $now->second . "\n";

=head1 DESCRIPTION

B<Ovid::DateTime::Tiny> is a local copy of Adam Kennedy's L<DateTime::Tiny>
module.

It implements an extremely lightweight object that represents a datetime.

=head1 METHODS

In general, the intent is that the API be as close as possible to the
API for L<DateTime>. Except, of course, that this module implements
less of it.

=head2 new

  my $date = Ovid::DateTime::Tiny->new(
      year   => 2006,
      month  => 12,
      day    => 31,
      hour   => 10,
      minute => 45,
      second => 32,
      );

The C<new> constructor creates a new B<Ovid::DateTime::Tiny> object.

It takes six named params. C<day> should be the day of the month (1-31),
C<month> should be the month of the year (1-12), C<year> as a 4 digit year.
C<hour> should be the hour of the day (0-23), C<minute> should be the
minute of the hour (0-59) and C<second> should be the second of the
minute (0-59).

These are the only params accepted.

Returns a new B<Ovid::DateTime::Tiny> object.

=head2 now

  my $current_date = Ovid::DateTime::Tiny->now;

The C<now> method creates a new date object for the current date.

The date created will be based on localtime, despite the fact that
the date is created in the floating time zone.

Returns a new B<Ovid::DateTime::Tiny> object.

=head2 year

The C<year> accessor returns the 4-digit year for the date.

=head2 month

The C<month> accessor returns the 1-12 month of the year for the date.

=head2 day

The C<day> accessor returns the 1-31 day of the month for the date.

=head2 hour

The C<hour> accessor returns the hour component of the time as
an integer from zero to twenty-three (0-23) in line with 24-hour
time.

=head2 minute

The C<minute> accessor returns the minute component of the time
as an integer from zero to fifty-nine (0-59).

=head2 second

The C<second> accessor returns the second component of the time
as an integer from zero to fifty-nine (0-59).

=head2 ymdhms

The C<ymdhms> method returns the most common and accurate stringified date
format, which returns in the form "2006-04-12".

=head2 from_string

The C<from_string> method creates a new B<Ovid::DateTime::Tiny> object from a
string.

The string is expected to be an ISO 8601 time, with seperators.

  my $almost_midnight = Ovid::DateTime::Tiny->from_string( '2006-12-20T23:59:59' );

Returns a new B<Ovid::DateTime::Tiny> object, or throws an exception on error.

=head2 as_string

The C<as_string> method converts the date to the default string, which
at present is the same as that returned by the C<ymd> method above.

This string matches the ISO 8601 standard for the encoding of a date as
a string.

=head2 DateTime

The C<DateTime> method is used to create a L<DateTime> object that is
equivalent to the B<Ovid::DateTime::Tiny> object, for use in comversions and
caluculations.

As mentioned earlier, the object will be set to the 'C' locate,
and the 'floating' time zone.

If installed, the L<DateTime> module will be loaded automatically.

Returns a L<DateTime> object, or throws an exception if L<DateTime>
is not installed on the current host.
