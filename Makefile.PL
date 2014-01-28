#!/usr/bin/env perl
use 5.010001;
use inc::Module::Install;

name 'Ovid';
version 1.0;

requires 'DateTime'                        => '1.03';
requires 'HTML::TokeParser::Simple'        => '3.16';
requires 'JSON'                            => '2.90';
requires 'Plack'                           => '1.0030';
requires 'Devel::Cover'                    => '1.08';
test_requires 'Capture::Tiny'              => '0.23';
test_requires 'File::Find::Rule'           => '0.33';
test_requires 'Sub::Override'              => '0.09';
test_requires 'Test::Exception'            => '0.32';
test_requires 'Test::Fatal'                => '0.013';
test_requires 'Test::More'                 => '0.96';
test_requires 'Test::Most'                 => '0.31';
test_requires 'Test::WWW::Mechanize::PSGI' => '0.35';

auto_install;
WriteAll;
