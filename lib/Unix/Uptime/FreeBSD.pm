package Unix::Uptime::FreeBSD;

sub uptime {
    my $class = shift;
    
    my $boottime = `sysctl kern.boottime`;
    my ($boot_seconds) = $boottime =~ /\s+sec\s+=\s+(\d+),/;
    my $time = time();
    my $uptime = $time - $boot_seconds;
    return $uptime;
}

1;
