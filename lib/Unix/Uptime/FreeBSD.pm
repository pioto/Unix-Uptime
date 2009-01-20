package Unix::Uptime::FreeBSD;
use warnings;
use strict;

sub uptime {
    my $class = shift;
    
    my $boottime = `sysctl kern.boottime`;
    my ($boot_seconds,$boot_useconds) = $boottime =~ /\s+sec\s+=\s+(\d+),\s+usec\s+=\s+(\d+)/;
    my $uptime;
    if ($class->want_hires()) {
        my $time = Time::HiRes::gettimeofday();
        my $boot_time = $boot_seconds + ($boot_useconds * (10.0**-6));
        $uptime = $time - $boot_time;
    } else {
        my $time = time();
        $uptime = $time - $boot_seconds;
    }
    return $uptime;
}

sub load_hires {
    my $class = shift;

    require Time::HiRes;
}

1;
