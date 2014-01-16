use Test::More;

use Ovid::Utilities qw(red green);

die <<'END';
This test needs to skip if we are on Windows
    ($^O is 'MSWin32')

Note that $^O has a capital "oh", not a zero

Or we're not running via prove's verbose mode
    $ENV{TEST_VERBOSE} is true
END

confirm( red("Is this text red?") );
confirm( green("Is this text green?") );

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
