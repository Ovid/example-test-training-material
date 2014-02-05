use strict;
use warnings;

package Ovid::Tests;
use 5.010;
use base 'Test::Builder::Module';
our @EXPORT = qw(
  confirm_ok
  in_range_ok
);

sub builder { state $BUILDER = Test::Builder->new }

sub confirm_ok($;$) {
    my ( $text, $message ) = @_;
    builder->diag("$text [y/N]");
    my $response = <STDIN>;
    $response =~ /^y/i
      ? builder->ok( 1, $message // "Passed test: $text" )
      : builder->ok( 0, $message // "Failed test: $text" );
}

# XXX For extra credit, you could install Test::Tester and write tests to
# verify that these tests work
sub in_range_ok($$$;$) {
    my ( $result, $min, $max, $message ) = @_;
    $message //= "$result should be between $min and $max";
    my $passed = $result >= $min && $result <= $max;
    builder->ok( $passed, $message );
}

1;
