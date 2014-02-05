use Test::Most;

use Ovid::Utilities ':all';

SKIP: {
    skip "ANSI color codes not supported on Windows", 2
      if 'MSWin32' eq $^O;
    skip "Skipping manual confirmation because test is not verbose", 2
      unless $ENV{TEST_VERBOSE};
    confirm( red("Is this text red?") );
    confirm( green("Is this text green?") );
}

diag <<'END';

The following test fails because we have code that's printing "ok" to STDOUT.
Thus, the test harness sees the following output:

	ok 1 - Passed test: Is this text red?
	ok 2 - Passed test: Is this text green?
	ok ... this goes to STDOUT
	ok 3 - messy() should return the answer
	1..3

Remember that test numbers are *optional*, but if they're present, they must
be in sequence. As a result, it looks like "ok ... this goes to STDOUT"
represents another test, even though it doesn't.

To make this pass, assume that the function cannot be changed. Use
Capture::Tiny to capture STDOUT, STDERR (because we don't want that extra
information spit out during our test run and causing messy output) and the
output of the messy() function.

END

is messy(), 42, 'messy() should return the answer';

sub confirm {
    my $text = shift;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    diag "$text [y/N]";
    my $response = <STDIN>;
    $response =~ /^y/i
      ? pass("Passed test: $text")
      : fail("Failed test: $text");
}

done_testing;
