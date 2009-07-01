package Unix::Uptime::BSD::Load;

use warnings;
use strict;

our $VERSION='0.34';
$VERSION = eval $VERSION;

sub load {
    my $class = shift;

    local $ENV{PATH} .= ':/usr/local/sbin:/usr/sbin:/sbin';
    my $loadavg = `sysctl vm.loadavg`;

    # OpenBSD:
    #   vm.loadavg=2.54 2.47 2.48
    # FreeBSD:
    #   vm.loadavg: { 0.53 0.24 0.19 }

    my ($load1, $load5, $load15) = $loadavg =~ /vm\.loadavg\s*[:=]\s*\{?\s*(\d+\.?\d*)\s+(\d+\.?\d*)\s+(\d+\.?\d*)/;

    return ($load1, $load5, $load15);
}

1;

__END__

=head1 NAME

Unix::Uptime::BSD::Load - BSD implementation of Unix::Uptime->load()

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
