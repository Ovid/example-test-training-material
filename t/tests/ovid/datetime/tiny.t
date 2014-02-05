use Test::More;
use Ovid::DateTime::Tiny;
use Sub::Override;
my $module = 'Ovid::DateTime::Tiny';

can_ok $module, 'new';
my $datetime = $module->new(
    year => 2006, month  => 12, day    => 25,
    hour => 10,   minute => 45, second => 0,
);
isa_ok $datetime, $module;
is $datetime->as_string, '2006-12-25T10:45:00',
  "as_string() should return the correct datetime";

my %args_for_now = (
    year => 2011, month  => 4,  day    => 23,
    hour => 18,   minute => 22, second => 4,
);
my $override = Sub::Override->new(
    "${module}::now" => sub { $module->new(%args_for_now) },
);
my $now = $module->now;

while ( my ( $method, $value ) = each %args_for_now ) {
    is $now->$method, $value, "$method should return the correct value";
}

my $datetime = $now->DateTime;
isa_ok $datetime, 'DateTime';
foreach (keys %args_for_now) {
    is $datetime->$_, $now->$_,
      "... and DateTime->$_ should return the same value as $module->$_";
}

done_testing;
