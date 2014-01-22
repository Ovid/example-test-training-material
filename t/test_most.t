# the 'die' argument in Test::Most's import list says "halt on first failure"
# We use it here because this test output is *very*
use Test::Most 'die';
use File::Find::Rule;

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
