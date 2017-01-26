package Unix::Uptime::Solaris;

use warnings;
use strict;

our $VERSION='0.4000';
$VERSION = eval $VERSION;

sub uptime {
    my $class = shift;
    my $kstat_out = `/usr/bin/kstat -p unix:0:system_misc:boot_time`;
    my $boot_time = (split(/\s+/, $kstat_out))[1];
    my $uptime = time() - $boot_time;
    return $uptime;
}

sub uptime_hires {
    my $class = shift;
    # short-circuit to the non-hires method.
    # An XS function is needed if we want hires.
    return $class->uptime();
}

sub load {
    my $class = shift;

    # For the magic number 256 see http://www.brendangregg.com/K9Toolkit/uptime
    my @loads = map {
        my $kstat_out = `/usr/bin/kstat -p unix:0:system_misc:avenrun_${_}min`;
        (split(/\s+/, $kstat_out))[1] / 256;
    } qw(1 5 15);
    return map { sprintf("%.2f", $_); } @loads;
}

1;

__END__

=head1 NAME

Unix::Uptime::Solaris - Solaris implementation of Unix::Uptime

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
