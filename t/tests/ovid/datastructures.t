use Test::More;
use Test::Differences;
use Test::Deep;

use Ovid::DataStructures qw(:all);

my $json = '{"foo":"bar","abc":[1,2,[3,2]],"baz":"quux"}';

my %expected = (
    foo => 'bar',
    baz => 'quux',
    abc => [ 1, 2, [ 3, 2 ] ],
);

eq_or_diff from_json($json), \%expected, 'JSON should deserialize correctly';
eq_or_diff get_customer('unknown'), {},
  'get_customer() should return an empty hashref for unknown customers';

my %expected = (
    customer_id => re('^\d{6}'),
    name        => code( \&non_empty_string ),
    age         => code( sub { shift >= 21 } ),
    active      => any( 1, 0 ),
    categories  => array_each( code( \&non_empty_string ) ),
);

foreach my $name (qw/bob sally elon ricardo/) {
    cmp_deeply get_customer($name), \%expected,
      "customer '$name' should return reasonable results";
}

sub non_empty_string {
    local $_ = shift;
    return 1 if defined && !ref($_) && /\S/;
    return 0, "Must be a string with one non-whitespace character";
}

done_testing;
