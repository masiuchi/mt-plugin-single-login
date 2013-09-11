package MT::Plugin::SingleLogin;
use strict;
use warnings;
use base qw( MT::Plugin );

my $plugin = __PACKAGE__->new(
    {   name        => 'SingleLogin',
        version     => '0.01',
        author_name => 'masiuchi',
        author_link => 'https://github.com/masiuchi',
        plugin_link => 'https://github.com/masiuchi/mt-plugin-single-login',
        description => '<__trans phrase="Login singly.">',
        registry    => {
            l10n_lexicon => {
                ja => {
                    'Login singly.' =>
                        '多重ログインできないようにします。',
                },
            },
        },
    }
);
MT->add_plugin($plugin);

{
    use MT::App;
    my $make_session = \&MT::App::make_session;
    no warnings 'redefine';
    *MT::App::make_session = sub {
        my ( $auth, $remember ) = @_;
        $auth->remove_sessions;
        $make_session->( $auth, $remember );
    };
}

1;
