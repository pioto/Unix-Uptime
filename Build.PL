use lib inc; use Devel::AssertOS qw(Linux FreeBSD DragonflyBSD OpenBSD MacOSX NetBSD);

use strict;
use warnings;

use Module::Build 0.28;

my $IS_BSD = $^O =~ /^(?:darwin|dragonfly|(?:free|open|net)bsd)$/;
my $IS_LINUX = $^O eq 'linux';
my $WANT_XS = $IS_BSD || $IS_LINUX;
$WANT_XS = 0 if $ENV{NO_XS};

my $build = Module::Build->new(
    module_name     => 'Unix::Uptime',
    license         => 'perl',
    sign            => 1,
    configure_requires  => {
        'Module::Build' => 0.28,
    },
    build_requires  => {
        'Module::Build' => 0.28,
        ($WANT_XS ? ('ExtUtils::CBuilder' => 0) : ()),
    },
    recommends => {
        ($IS_BSD ? ('Time::HiRes' => 0) : ()),
    },
    meta_merge => {
        resources => {
            repository => 'https://github.com/pioto/Unix-Uptime',
            license => 'http://dev.perl.org/licenses/',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Unix-Uptime',
        },
    },
);
if ($WANT_XS) {
    if ($IS_LINUX) {
        $build->xs_files({'lib/Unix/Uptime/Linux/XS.xs' => 'lib/Unix/Uptime/Linux/XS.xs'});
    } elsif ($IS_BSD) {
        $build->xs_files({'lib/Unix/Uptime/BSD/XS.xs' => 'lib/Unix/Uptime/BSD/XS.xs'});
    }
} else {
    $build->xs_files({});
}
$build->create_build_script();

