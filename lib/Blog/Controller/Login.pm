package Blog::Controller::Login;
use Moose;
use namespace::autoclean;
use Digest::MD5 qw(md5_hex);
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

Login logic

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    if($c->request->method eq "POST")
    {
        # Get the username and password from form
        my $username = $c->request->params->{username};
        my $password = md5_hex($c->request->params->{password});

        # If the username and password values were found in form
        if ($username && $password) {
            # Attempt to log the user in
            if ($c->authenticate({ username => $username, password => $password } )) {
                # If successful, then let them use the application
                $c->response->redirect($c->uri_for($c->controller('Users')->action_for('list')));
                return;
            } else {
                # Set an error message
                $c->stash(error_msg => "Bad username or password.");
            }
        } else {
            # Set an error message
            $c->stash(error_msg => "Empty username or password.")
                unless ($c->user_exists);
        }
    }else{
        $c->stash(error_msg => "");
    }

    # If either of above don't work out, send to the login page
    $c->stash(template => 'auth/login.tt');
}



=encoding utf8

=head1 AUTHOR

Habib,ali,mohamed

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
