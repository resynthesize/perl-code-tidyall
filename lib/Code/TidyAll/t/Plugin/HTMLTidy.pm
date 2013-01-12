package Code::TidyAll::t::Plugin::HTMLTidy;
use Test::Class::Most parent => 'Code::TidyAll::t::Plugin';

sub test_main : Tests {
    my $self = shift;

    my $source = '<ul><li>sometext';
    $self->tidyall(
        source      => $source,
	conf => { argv => '--show-warnings n --show-body-only t' }, 
	expect_tidy => '<ul>\n<li>sometext</li>\n</ul>\n'
    );
    $self->tidyall(
        source      => $source,
	conf => { argv => '--show-warnings n --show-body-only t -i' }, 
	expect_tidy => '<ul>\n  <li>sometext</li>\n</ul>\n'
    );
    $self->tidyall(
        source       => $source,
        conf         => { argv => '--badoption' },
        expect_error => qr/exited with error/
    );
}

1;
