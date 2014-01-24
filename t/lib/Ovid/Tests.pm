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

sub in_range_ok($$$;$) {
    builder->ok( 0, 'make these tests pass' );
}

1;
