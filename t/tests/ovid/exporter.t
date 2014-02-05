use Test::Most;

{
    BEGIN { $INC{'Example.pm'} = 1; }    # stop "use" from breaking

    package Example;
    use Ovid::Exporter qw(foo bar);
    sub foo {1}
    sub bar {2}
}

{
    package Test::Example;
    use Example qw(foo bar);
    ::is foo(), 1, 'We should be able to export foo()';
    ::is bar(), 2, '... and bar() via :all';
}
{
    package Test::Example::All;
    use Example qw(:all);
    ::is foo(), 1, 'We should be able to export foo() via :all';
    ::is bar(), 2, '... and bar() via :all';
}

done_testing;
