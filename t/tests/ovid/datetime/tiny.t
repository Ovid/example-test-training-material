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
like $now->as_string, qr/^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d$/,
  '... and now() should return something resembling a datetime string';

my $datetime = $now->DateTime;
isa_ok $datetime, 'DateTime';
foreach (qw/year month day hour minute second/) {
    is $datetime->$_, $now->$_,
      "... and DateTime->$_ should return the same value as $module->$_";
}

done_testing;
