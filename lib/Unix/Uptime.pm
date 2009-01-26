package Unix::Uptime;

use warnings;
use strict;

our $VERSION='0.3';

my %modules = (
    freebsd => 'FreeBSD',
    linux   => 'Linux',
    openbsd => 'BSD',
    darwin  => 'BSD',
);

my $module = $modules{$^O}
    or die "Operating system type $^O is currently unupported";

require "Unix/Uptime/$module.pm";
our @ISA = ("Unix::Uptime::$module");

my $hires;

sub want_hires {
    my $class = shift;

    return $hires;
}

sub import {
    my $class = shift;
    if (grep {$_ eq ':hires'} @_) {
        $hires = 1;
        "Unix::Uptime::$module"->can('load_hires')
            and "Unix::Uptime::$module"->load_hires();
    }
}

1;

__END__

=head1 NAME

Unix::Uptime - Determine the current uptime, in seconds, across
different *NIX architectures

=head1 SYNOPSIS

  # Standard Usage
  use Unix::Uptime;
  
  my $uptime = Unix::Uptime->uptime(); # 2345

  # "HiRes" mode
  use Unix::Uptime qw(:hires);

  my $uptime = Unix::Uptime->uptime_hires(); # 2345.123593

=head1 DESCRIPTION

This is a rather simple module that abstracts the task of figuring out
the current system uptime, in seconds. It was born out of a desire to do
this on non-Linux systems, without SNMP. If you want to use SNMP, there
are pleanty of modules on CPAN already.

Currently, this module just supports getting the uptime on Linux,
FreeBSD, Darwin (Mac OS X), and OpenBSD. It should be easy enough to add
support for other operating systems, though.

=head1 OPTIONS

While this module doesn't provide any functions for exporting, if the
tag C<:hires> is given, then the times returned will be returned as
decimal numbers when possible. This will likely require the Time::HiRes
module to be available. Otherwise, they will simply be whole seconds.

=head1 METHODS

The following static (class) methods are available:

=head2 uptime()

This takes no arguments, and simply returns the number of seconds this
system has been running. Depending on the operating system, this could
be a whole integer, or a floating point number.

=head2 uptime_hires()

This is only available if the C<:hires> import tag is used. It returns
the system uptime with a greater resolution than one second on supported
platforms. On some platforms, its results may not be any more precise
than C<uptime()>, though.

=head1 SEE ALSO

L<Sys::Load>(3) and L<Sys::Uptime>(3) for Linux-specific implementations.

L<Win32::Uptime> for Win32.

=head1 BUGS

This currently doesn't support more than Linux and FreeBSD.
Contributions for other operating systems would be welcome.

=head1 CONTRIBUTING

This project is developed using git. The repository may be browsed at:
L<http://git.pioto.org/gitweb/Unix-Uptime.git>

Patches in git-format-patch style are preferred. Either send them to me
by email, or open an RT ticket.

=head1 AUTHOR

Mike Kelly <pioto@pioto.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2008, 2009 Mike Kelly

Distributed under the same terms as Perl itself. See
L<http://dev.perl.org/licenses/> for more information.

=cut

# vim: set ft=perl sw=4 sts=4 et :
