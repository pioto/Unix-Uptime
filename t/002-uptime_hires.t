#!/usr/bin/env perl
use warnings;
use strict;

use Test::More tests => 6;

use Unix::Uptime qw(:hires);

my $SLEEP_TIME = 2;

# "HiRes" mode
ok my $uptime = Unix::Uptime->uptime_hires(), 'received an uptime';
like $uptime, qr/^\d+(\.\d+)?$/, 'uptime looks right';

diag "Sleeping for $SLEEP_TIME seconds";
sleep $SLEEP_TIME;

ok my $new_uptime = Unix::Uptime->uptime_hires(), 'received an uptime';
like $new_uptime, qr/^\d+(\.\d+)?$/, 'uptime looks right';
cmp_ok $new_uptime, '>=', $uptime+$SLEEP_TIME, 'time passes properly';

my $pretty_uptime = `uptime`;
my ($up_days) = $pretty_uptime =~ /up (\d+) days?/;
$up_days ||= 0;
is (int($uptime / (60*60*24)), $up_days, 'uptime matches /bin/uptime');

