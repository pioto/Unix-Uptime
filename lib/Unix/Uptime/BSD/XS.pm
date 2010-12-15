package Unix::Uptime::BSD::XS;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT = qw(sysctl_kern_boottime sysctl_vm_loadavg);

our $VERSION='0.37';
$VERSION = eval $VERSION;

require XSLoader;
XSLoader::load('Unix::Uptime::BSD::XS', $VERSION);

1;

