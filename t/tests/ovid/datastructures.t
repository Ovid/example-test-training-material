use Test::More;

use Ovid::DataStructures qw(:all);

my $json = '{"foo":"bar","abc":[1,2,3],"baz":"quux"}';

my %expected = (
    foo => 'bar',
    baz => 'quux',
    abc => [ 1, 2, 3 ],
);


is_deeply from_json($json), \%expected,
	'JSON should deserialize correctly';

done_testing;
