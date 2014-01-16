use strict;
use warnings;

use Test::More;
eval "use Ovid::Telepathy";
plan skip_all => "Ovid::Telepathy cannot be loaded: $@" if $@;

ok my $telepathy = Ovid::Telepathy->new,
  'We should be able to create a new telephathy module';
diag $telepathy->what_you_are_thinking;

done_testing;
