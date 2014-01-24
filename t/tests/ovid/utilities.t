use lib 't/lib';
use Test::Most;
use Ovid::Tests;

use Ovid::Utilities ':all';
use Capture::Tiny 'capture';

SKIP: {
    skip "ANSI color codes not supported on Windows", 2
      if 'MSWin32' eq $^O;
    skip "Skipping manual confirmation because test is not verbose", 2
      unless $ENV{TEST_VERBOSE};
    confirm( red("Is this text red?") );
    confirm( green("Is this text green?") );
}

subtest 'Using Capture::Tiny' => sub {
    my ( $stdout, $stderr, @result ) = capture { messy() };
    is $stdout,   "ok ... this goes to STDOUT\n", 'Our STDOUT should be OK';
    like $stderr, qr/^This goes to STDERR/,       '... as should our STDERR';
    eq_or_diff \@result, [42], '... and out result';
};

done_testing;
