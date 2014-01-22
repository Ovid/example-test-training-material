use Test::Most;

use Ovid::Utilities qw(red green);

SKIP: {
    skip "ANSI color codes not supported on Windows", 2
      if 'MSWin32' eq $^O;
    skip "Skipping manual confirmation because test is not verbose", 2
      unless $ENV{TEST_VERBOSE};
    confirm( red("Is this text red?") );
    confirm( green("Is this text green?") );
}

sub confirm {
    my $text = shift;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    diag "$text? [y/N]";
    my $response = <STDIN>;
    $response =~ /^y/i
      ? pass("Passed test: $text")
      : fail("Failed test: $text");
}

done_testing;
