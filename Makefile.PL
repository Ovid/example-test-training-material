#!/usr/bin/env perl
use 5.010001;
use inc::Module::Install;

name 'Ovid';
version 1.0;

test_requires 'Test::More' => '0.96';

auto_install;
WriteAll;
