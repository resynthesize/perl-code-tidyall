package Code::TidyAll::Plugin::HTMLTidy;
use IPC::System::Simple qw(EXIT_ANY system);
use Capture::Tiny qw(capture_merged);
use Moo;
use Data::Dumper;
extends 'Code::TidyAll::Plugin';

sub _build_cmd { 'tidy -m' }

sub transform_file {
    my ( $self, $file ) = @_;

    my ( $exit, $warning_flag, $error_flag, $die_flag );
    my $cmd = sprintf( "%s %s %s", $self->cmd, $self->argv, $file );

    my $output = capture_merged {
        system( EXIT_ANY, $cmd );
    };

    if ( $output =~ /^line \d+ column \d+ - (?:Warning)|(?:Error)/ ) {
        die $output;
    }

}

1;

__END__

=pod

=head1 NAME

Code::TidyAll::Plugin::HTMLTidy - use HTMLTidy with tidyall

=head1 SYNOPSIS

   # In configuration:

   ; Configure in-line
   ;
   [HTMLTidy]
   select = lib/**/*.pm
   argv = -q -i --show-warnings n

   ; or refer to a tidy config file in the same directory
   ;
   [HTMLTidy]
   select = lib/**/*.pm
   argv = -config $ROOT/.htmltidyrc

   You can enable warnings by removing the "--show-warnings n" argument

=head1 DESCRIPTION

Runs L<tidy|tidy>, an HTML tidier.

=head1 INSTALLATION

Install HTMLTidy perltidy from http://tidy.sourceforge.net/.

=head1 CONFIGURATION

=over

=item argv

Arguments to pass to HTMLTidy

=back

