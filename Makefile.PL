#!/usr/bin/env perl
use 5.010001;
use inc::Module::Install;

name 'Ovid';
version 1.0;

requires 'DateTime'               => '0.23';
test_requires 'Test::Most'        => '0.08';
test_requires 'Test::Class::Most' => '0.30';

auto_install;
WriteAll;
