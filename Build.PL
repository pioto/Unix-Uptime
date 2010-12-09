use lib inc; use Devel::AssertOS qw(Linux FreeBSD DragonflyBSD OpenBSD MacOSX NetBSD);

use strict;
use warnings;

use Module::Build 0.28;

my $build = Module::Build->new(
    module_name     => 'Unix::Uptime',
    license         => 'perl',
    sign            => 1,
    configure_requires  => {
        'Module::Build' => 0.28,
    },
    build_requires  => {
        'Module::Build' => 0.28,
    },
    recommends => {
        ($^O =~ /^(?:darwin|(?:free|open|net)bsd)$/ ? ('Time::HiRes' => 0) : ()),
    },
    meta_merge => {
        resources => {
            repository => 'http://git.pioto.org/gitweb/Unix-Uptime.git',
            license => 'http://dev.perl.org/licenses/',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Unix-Uptime',
        },
    },
);
$build->create_build_script();

