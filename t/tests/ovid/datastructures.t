use Test::More;
use Test::Differences;

use Ovid::DataStructures qw(:all);

my $json = '{"foo":"bar","abc":[1,2,[3,2]],"baz":"quux"}';

my %expected = (
    foo => 'bar',
    baz => 'quux',
    abc => [ 1, 2, [ 3, 2 ] ],
);

eq_or_diff from_json($json), \%expected, 'JSON should deserialize correctly';

done_testing;
