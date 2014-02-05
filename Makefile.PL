#!/usr/bin/env perl
use 5.010001;
use inc::Module::Install;

name 'Ovid';
version 1.0;

requires 'DateTime'             => '1.03';
test_requires 'Sub::Override'   => '0.09';
test_requires 'Test::Exception' => '0.32';
test_requires 'Test::Fatal'     => '0.013';
test_requires 'Test::More'      => '0.96';

auto_install;
WriteAll;
