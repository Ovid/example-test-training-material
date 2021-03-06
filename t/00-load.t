use Test::Most;
use File::Find::Rule;
use File::Spec::Functions 'splitdir';

BEGIN {

    # this is an example of a data-driven testing solution. We cannot "use
    # Ovid::Exporter" because it requires that we provide it with a list of
    # subs to import. However, if we "require Ovid::Exporter", the import()
    # method is not called. If you have other modules that should be required
    # instead of used, put them in this list.
    my %should_require = map { $_ => 1 } qw(
      Ovid::Exporter
    );

    my @packages = File::Find::Rule->file->name('*.pm')->in('lib');
    foreach my $package (@packages) {
        my @path = splitdir($package);
        shift @path;    # discard lib/
        $package = join '::' => @path;
        $package =~ s/\.pm$//;
        if ( $should_require{$package} ) {
            require_ok $package or BAIL_OUT "Could not require $package";
        }
        else {
            use_ok $package or BAIL_OUT "Could not use $package";
        }
    }
}

done_testing;

__END__

=head1 NAME

t/00-load.t - Test that we can load all of our modules

=head1 DESCRIPTION

This is a simple test that searches for all modules in the C<lib> directory
and attempts to load them. If it cannot, C<BAIL_OUT()> will be called to halt
the test suite because we assume that there is something fundamentally broken.
