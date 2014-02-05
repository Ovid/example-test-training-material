use Test::More;

use Ovid::DataStructures qw(:all);

my $json = '{"foo":"bar","abc":[3,2,3],"baz":"quux"}';

my %expected = (
    foo => 'bar',
    baz => 'quux',
    abc => [ 1, 2, 3 ],
);

my $result = from_json($json);
is $result->{foo}, 'bar',  'foo is bar';
is $result->{baz}, 'quux', 'bar is quux';
is $result->{abc}[0], 1, 'abc.0 is 1';
is $result->{abc}[1], 2, 'abc.1 is 2';
is $result->{abc}[2], 3, 'abc.2 is 3';
fail <<"END";

	Rewrite these tests using a single 'is_deeply()' test, THEN fix the tests.
	We've provided an %expected data structure for you.
END

done_testing;
