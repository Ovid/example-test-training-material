use strict;
use warnings;

package Ovid::Tests;
use Test::More;
use base 'Test::Builder::Module';
our @EXPORT = qw(confirm);

sub confirm {
    my $text = shift;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    diag "$text [y/N]";
    my $response = <STDIN>;
    $response =~ /^y/i
      ? pass("Passed test: $text")
      : fail("Failed test: $text");
}

1;
