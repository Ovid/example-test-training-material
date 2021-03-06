use Test::Most;
eval "use Ovid::Telepathy";

# Oridinarily we'd print the error message too ($@), but we want our test
# output to be succint during training.
plan skip_all => "Ovid::Telepathy cannot be loaded" if $@;

ok my $telepathy = Ovid::Telepathy->new,
  'We should be able to create a new telephathy module';
diag $telepathy->what_you_are_thinking;

done_testing;
