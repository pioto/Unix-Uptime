#!/usr/bin/env perl
use warnings;
use strict;

use Test::More tests => 5;

use Unix::Uptime;

my $SLEEP_TIME = 2;

ok my $uptime = Unix::Uptime->uptime(), 'received an uptime';
like $uptime, qr/^\d+(\.\d+)?$/, 'uptime looks right';

diag "Sleeping for $SLEEP_TIME seconds";
sleep $SLEEP_TIME;

ok my $new_uptime = Unix::Uptime->uptime(), 'received an uptime';
like $new_uptime, qr/^\d+(\.\d+)?$/, 'uptime looks right';
cmp_ok $new_uptime, '>=', $uptime+$SLEEP_TIME, 'time passes properly';

