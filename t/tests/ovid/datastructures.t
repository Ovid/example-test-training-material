use Test::More;

use Ovid::DataStructures qw(:all);

my $json = '{"foo":"bar","abc":[1,2,[3,2]],"baz":"quux"}';

my %expected = (
    foo => 'bar',
    baz => 'quux',
    abc => [ 1, 2, [ 2, 4 ] ],
);

is_deeply from_json($json), \%expected, 'JSON should deserialize correctly';
diag <<"END";
	Use the Test::Differences module. Change is_deeply() to eq_or_diff() and
	fix the test.
END

done_testing;
