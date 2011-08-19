package Unix::Uptime::Linux::XS;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT = qw(sysinfo_uptime sysinfo_loads);

our $VERSION='0.3701';
$VERSION = eval $VERSION;

require XSLoader;
XSLoader::load('Unix::Uptime::Linux::XS', $VERSION);

1;

__END__

=head1 NAME

Unix::Uptime::Linux::XS - XS-based Linux implementation of Unix::Uptime

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
