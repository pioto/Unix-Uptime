package Unix::Uptime::Linux;

use warnings;
use strict;

our $VERSION='0.32';
$VERSION = eval $VERSION;

sub uptime {
    my $class = shift;
    open my $proc_uptime, '<', '/proc/uptime'
        or die "Failed to open /proc/uptime: $!";

    my $line = <$proc_uptime>;
    my ($uptime) = $line =~ /^(\d+)/;
    return $uptime;
}

sub uptime_hires {
    my $class = shift;

    unless ($class->want_hires()) {
        die "uptime_hires: you need to import Unix::Uptime with ':hires'";
    }

    open my $proc_uptime, '<', '/proc/uptime'
        or die "Failed to open /proc/uptime: $!";

    my $line = <$proc_uptime>;
    my ($uptime) = $line =~ /^(\d+(\.\d+)?)/;
    return $uptime;
}

1;

__END__

=head1 NAME

Unix::Uptime::Linux - Linux implementation of Unix::Uptime

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
