use Module::Build;
my $build = Module::Build->new(
    module_name => 'Unix::Uptime',
    license     => 'perl',
    requires    => {
    },
);
$build->create_build_script();

