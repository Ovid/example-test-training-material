# the 'die' argument in Test::Most's import list says "halt on first failure"
# We use it here because this test output is *very*
use Test::Most 'die';
use File::Find::Rule;

diag <<'END';

This is a very, very bad test. It spiders through the test files in your test
directory and verifies that none of the files use strict, warnings,
Test::More, Test::Differences, Test::Deep, or Test::Warn. The tests will pass
when all of those have been removed and replaced with Test::Most. The idea is
that you can replace this:

    use strict;
    use warnings;
    use Test::Exception 0.88;
    use Test::Differences 0.500;
    use Test::Deep 0.106;
    use Test::Warn 0.11;
    use Test::More tests => 42;

With this:

    use Test::Most tests => 42;

This exercise is merely to show you how well Test::Most reduces boilerplate.
This particular test program will be removed for the next lesson. If you
prefer the boilerplate, by all means, go ahead and use it.

END

my @tests = File::Find::Rule->file->name('*.t')->in('t');
my $unwanted = join '|' => qw/
  strict
  warnings
  Test::More
  Test::Differences
  Test::Deep
  Test::Warn
  /;

foreach my $test (@tests) {
    next if $test =~ /test_most/; # skip this test program
    open my $fh, '<', $test
      or die "Cannot open '$test' for reading: $!";
    my $code = do { local $/; <$fh> };    # slurp in entire file
    unlike $code, qr/\b(?:$unwanted)\b/, 'File should not match $unwanted';
    like $code, qr/\bTest::Most\b/, '... but should use Test::Most instead';
}

done_testing;
