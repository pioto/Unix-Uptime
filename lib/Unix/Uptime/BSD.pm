package Unix::Uptime::BSD;

use warnings;
use strict;

our $VERSION='0.33_01';
$VERSION = eval $VERSION;

use DateTime::Format::Strptime;

sub uptime {
    my $class = shift;

    $ENV{PATH} .= ':/usr/local/sbin:/usr/sbin:/sbin';
    my $boottime = `sysctl kern.boottime`;

    $boottime =~ s/^\s*kern\.boottime\s*=\s*//;
    # OpenBSD:
    #   kern.boottime=Mon Jan  5 14:00:50 2009
    # Darwin:
    #   kern.boottime = Wed Jan 21 12:49:52 2009
    # NetBSD:
    #   kern.boottime = Mon Jan  5 15:30:35 2009
    my $strp = DateTime::Format::Strptime->new(
        pattern => '%a%t%b%t%d%t%T%t%Y',
    );
    my $dt = $strp->parse_datetime($boottime)
        or die "Failed to parse kern.boottime: ",$strp->errstr;
    return time() - $dt->epoch();
}

no warnings qw(once);
*uptime_hires = \&uptime;

use base 'Unix::Uptime::BSD::Load';

1;

__END__

=head1 NAME

Unix::Uptime::BSD - BSD implementation of Unix::Uptime (for Darwin, OpenBSD, and NetBSD)

=head1 SEE ALSO

L<Unix::Uptime>

=cut

# vim: set ft=perl sw=4 sts=4 et :
