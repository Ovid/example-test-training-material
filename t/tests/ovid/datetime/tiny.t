use Test::More;
use Ovid::DateTime::Tiny;
my $module = 'Ovid::DateTime::Tiny';

can_ok $module, 'new';
my $datetime = $module->new(
    year => 2006, month  => 12, day    => 25,
    hour => 10,   minute => 45, second => 0,
);
isa_ok $datetime, $module;
is $datetime->as_string, '2006-12-25T10:45:00',
    "as_string() should return the correct datetime";

my $now = $module->now;
diag $now->as_string;
fail 'Use like($string,$regex,$description) to test $now';

done_testing;