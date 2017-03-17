package Blog::Controller::Auth;
use Moose;
use Digest::MD5 qw(md5_hex);
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base :Chained('/') :PathPart('books')
    :CaptureArgs(0) {
    my ($self, $c) = @_;
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::User'));
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}


=head2 form_create_do
Take information from form and add to database

=cut

sub doRegister :Path('/save'){
    my ($self, $c) = @_;
    # Retrieve the values from the form
    my $username = $c->request->params->{username} || '';
    my $email = $c->request->params->{email} || '';
    my $password= $c->request->params->{password} || '';
    if ($username && $email && $password)
    {
        my $valid = $email =~ /^[a-z0-9.]+\@[a-z0-9.-]+$/;
        if ($valid)
        {
            my $user = $c->model('DB::User')->create({
                username => $username,
                email => $email,
                password => md5_hex($password),
            });

            $c->stash(user => $user, template => 'users');
        }
    }
}

=head2 form_create
Display form to collect information for user to
create

=cut
sub showRegister :Path('/register') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(template => 'auth/register.tt');
}


__PACKAGE__->meta->make_immutable;

1;
