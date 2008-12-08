=head1 NAME

Unix::Uptime - Determine the current uptime, in seconds, across
different *NIX architectures

=head1 SYNOPSIS

  use Unix::Uptime;
  
  my $uptime = Unix::Uptime->uptime();

=head1 DESCRIPTION

This is a rather simple module that abstracts the task of figuring out
the current system uptime, in seconds. It was born out of a desire to do
this on non-Linux systems, without SNMP. If you want to use SNMP, there
are pleanty of modules on CPAN already.

Currently, this module just supports getting the uptime on Linux and
FreeBSD. It should be easy enough to add support for other operating
systems, though.

=head1 METHODS

The following static (class) methods are available:

=cut

package Unix::Uptime;

use warnings;
use strict;

our $VERSION='0.1';

=head2 uptime()

This takes no arguments, and simply returns the number of seconds this
system has been running. Depending on the operating system, this could
be a whole integer, or a floating point number.

=cut
sub uptime {
    my $class = _os_class();

    return $class->uptime();
}

# Figure out the right package name for the current os.
sub _os_class {
    my $os = $^O;
    $os =~ s/^(.)/\U$1/;
    my $os_class = "Unix::Uptime::$os";
    return $os_class;
}

####
# FreeBSD-specific functions
package Unix::Uptime::Freebsd;

sub uptime {
    my $class = shift;
    
    my $boottime = `sysctl kern.boottime`;
    my $boot_seconds = $boottime =~ /\s+sec\s+=\s+(\d+),/;
    my $time = time();
    my $uptime = $time - $boot_seconds;
    return $uptime;
}

####
# Linux-specific functions
package Unix::Uptime::Linux;

sub uptime {
    my $class = shift;
    open my $proc_uptime, '<', '/proc/uptime'
        or die "Failed to open /proc/uptime: $!";

    my $line = <$proc_uptime>;
    my ($uptime) = $line =~ /^(\d+(\.\d+)?)/;
    return $uptime;
}

=head1 SEE ALSO

L<Sys::Load>(3) and L<Sys::Uptime>(3) for Linux-specific implementations.

L<Win32::Uptime> for Win32.

=head1 BUGS

This currently doesn't support more than Linux and FreeBSD.
Contributions for other operating systems would be welcome.

=head1 AUTHOR

Mike Kelly <pioto@pioto.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Mike Kelly

Distributed under the same terms as Perl itself. See
L<http://dev.perl.org/licenses/> for more information.

=cut
# vim: set ft=perl sw=4 sts=4 et :
