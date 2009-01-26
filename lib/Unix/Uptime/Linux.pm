package Unix::Uptime::Linux;

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
