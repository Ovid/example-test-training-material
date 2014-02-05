use Test::Most;
use Ovid::DateTime::Tiny;
use Sub::Override;
my $module = 'Ovid::DateTime::Tiny';

subtest 'constructor' => sub {
    can_ok $module, 'new';
    my $datetime = $module->new(
        year => 2006, month  => 12, day    => 25,
        hour => 10,   minute => 45, second => 0,
    );
    isa_ok $datetime, $module;
    is $datetime->as_string, '2006-12-25T10:45:00',
      "as_string() should return the correct datetime";

    $datetime = $module->new;
    is $datetime->as_string, '1970-01-01T00:00:00',
      "Creating a $module object without arguments should default to the Unix epoch";
};

subtest 'from_string()' => sub {
    throws_ok { $module->from_string }
    qr/^Did not provide a string to from_string/,
      'Calling from_string() without arguments should fail';
    throws_ok { $module->from_string([]) }
    qr/^Did not provide a string to from_string/,
      '.. and passing it a reference should fail';
    throws_ok { $module->from_string('1967-06-20') }
    qr/^\QInvalid time format (does not match ISO 8601)/,
      '... and passing it a bad string should also fail';
    my $datetime;
    lives_ok { $datetime = $module->from_string('1967-06-20T00:00:01') }
    'Calling from_string() with an ISO 8601 string should succeed';
    my %expected = (
        year   => 1967,
        month  => 6,
        day    => 20,
        hour   => 0,
        minute => 0,
        second => 1,
    );
    while ( my ( $method, $expected ) = each %expected ) {
        is $datetime->$method, $expected,
          "... and $method should return the correct value";
    }
};

subtest 'now()' => sub {
    my $now = $module->now;

    my $d = '[0-9]';
    like $now->as_string, qr/^$d$d$d$d-$d$d-$d${d}T$d$d:$d$d:$d$d$/,
      "$module->now should create a reasonble looking string";

    my %args_for_now = (
        year => 2011, month  => 4,  day    => 23,
        hour => 18,   minute => 22, second => 4,
    );

    my $override = Sub::Override->new(
        "${module}::now" => sub { $module->new(%args_for_now) },
    );
    $now = $module->now;

    while ( my ( $method, $value ) = each %args_for_now ) {
        is $now->$method, $value, "$method should return the correct value";
    }

    my $datetime = $now->DateTime;
    isa_ok $datetime, 'DateTime';
    foreach ( keys %args_for_now ) {
        is $datetime->$_, $now->$_,
          "... and DateTime->$_ should return the same value as $module->$_";
    }
};

done_testing;
