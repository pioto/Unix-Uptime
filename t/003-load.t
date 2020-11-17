#!/usr/bin/env perl
use warnings;
use strict;

use Test::More tests => 6;

use Unix::Uptime;

$ENV{LC_ALL} = 'C';

my ($load1, $load5, $load15);
my ($pload1, $pload5, $pload15);

for (1..2) {
    ($load1, $load5, $load15) = Unix::Uptime->load();
    my $pretty_uptime = `uptime`;
    ($pload1, $pload5, $pload15) = $pretty_uptime =~ /load\s+averages?:\s+(\d+\.?\d*),?\s+(\d+\.?\d*),?\s+(\d+\.?\d*)/i;
    last if ($load1 == $pload1 && $load5 == $pload5 && $load15 == $pload15);
}

like $load1, qr/^\d+(\.\d+)?$/, 'load1 looks right';
like $load5, qr/^\d+(\.\d+)?$/, 'load5 looks right';
like $load15, qr/^\d+(\.\d+)?$/, 'load15 looks right';

is $load1, $pload1;
is $load5, $pload5;
is $load15, $pload15;

