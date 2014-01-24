use strict;
use warnings;
use Plack::Builder;
use Ovid::Web::Hello ':all';

builder {
    mount '/'          => hello();
    mount '/style.css' => style();
}
