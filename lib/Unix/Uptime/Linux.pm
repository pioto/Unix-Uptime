package Unix::Uptime::Linux;

sub uptime {
    my $class = shift;
    open my $proc_uptime, '<', '/proc/uptime'
        or die "Failed to open /proc/uptime: $!";

    my $line = <$proc_uptime>;
    my ($uptime) = $line =~ /^(\d+(\.\d+)?)/;
    return $uptime;
}

1;
