package Unix::Uptime::FreeBSD;

use warnings;
use strict;

our $VERSION='0.34';
$VERSION = eval $VERSION;

sub uptime {
    my $class = shift;
    
    local $ENV{PATH} .= ':/usr/local/sbin:/usr/sbin:/sbin';
    my $boottime = `sysctl kern.boottime`;
    my ($boot_seconds,$boot_useconds) = $boottime =~ /\s+sec\s+=\s+(\d+),\s+[un]sec\s+=\s+(\d+)/;
    return time() - $boot_seconds;
}

sub uptime_hires {
    my $class = shift;

    unless ($class->want_hires()) {
        die "uptime_hires: you need to import Unix::Uptime with ':hires'";
    }

    local $ENV{PATH} .= ':/usr/local/sbin:/usr/sbin:/sbin';
    my $boottime = `sysctl kern.boottime`;
    my ($boot_seconds,$boot_useconds) = $boottime =~ /\s+sec\s+=\s+(\d+),\s+[un]sec\s+=\s+(\d+)/;
    my $time = Time::HiRes::gettimeofday();
    # this isn't strictly correct on dfly. but i don't think it actually
    # uses a real nsec value, so that's ok.
    my $boot_time = $boot_seconds + ($boot_useconds * (10.0**-6));
    return $time - $boot_time;
}

sub load_hires {
    my $class = shift;

    require Time::HiRes;
}

use base 'Unix::Uptime::BSD::Load';

1;

__END__

=head1 NAME

Unix::Uptime::FreeBSD - FreeBSD implementation of Unix::Uptime

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
