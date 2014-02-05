use strict;
use warnings;

package Ovid::DataStructures;
use Ovid::Exporter qw(to_json from_json get_customer);   # re-export from JSON
use Ovid::Exam1 qw(roll_dice);
use JSON qw(to_json from_json);

sub get_customer {
    my $name      = shift;
    my %customers = (
        bob     => [ 'Bob Dobbs',      [qw/religion/] ],
        sally   => [ 'Sally Ride',     [qw/teaching/] ],
        elon    => [ 'Elon Musk',      [qw/space technology business/] ],
        ricardo => [ 'Ricardo Semler', [qw/business maverick/] ],
    );
    return {} unless my $customer = $customers{$name};
    return {
        customer_id => sprintf( "%06d" => int( rand(1_000_000) ) ),
        name        => $customer->[0],
        categories  => $customer->[1],
        age    => 20 + roll_dice( { times => 3 } ),
        active => int( rand(1) + .5 ),
    };
}

1;
