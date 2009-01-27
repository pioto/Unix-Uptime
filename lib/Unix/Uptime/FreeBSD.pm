package Unix::Uptime::FreeBSD;

use warnings;
use strict;

our $VERSION='0.30_01';
$VERSION = eval $VERSION;

sub uptime {
    my $class = shift;
    
    my $boottime = `sysctl kern.boottime`;
    my ($boot_seconds,$boot_useconds) = $boottime =~ /\s+sec\s+=\s+(\d+),\s+usec\s+=\s+(\d+)/;
    return time() - $boot_seconds;
}

sub uptime_hires {
    my $class = shift;

    unless ($class->want_hires()) {
        die "uptime_hires: you need to import Unix::Uptime with ':hires'";
    }

    my $boottime = `sysctl kern.boottime`;
    my ($boot_seconds,$boot_useconds) = $boottime =~ /\s+sec\s+=\s+(\d+),\s+usec\s+=\s+(\d+)/;
    my $time = Time::HiRes::gettimeofday();
    my $boot_time = $boot_seconds + ($boot_useconds * (10.0**-6));
    return $time - $boot_time;
}

sub load_hires {
    my $class = shift;

    require Time::HiRes;
}

1;

__END__

=head1 NAME

Unix::Uptime::FreeBSD - FreeBSD implementation of Unix::Uptime

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
