package Blog::Controller::Register;
use Moose;
use namespace::autoclean;
use Digest::MD5 qw(md5_hex);
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::Register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


sub index :Path :Args(0) {
    my ($self, $c) = @_;
    # Retrieve the values from the form
    if($c->request->method eq "POST")
    {
        my $username = $c->request->params->{username} || '';
        my $email = $c->request->params->{email} || '';
        my $password= $c->request->params->{password} || '';
        my $repassword= $c->request->params->{repassword} || '';
        if ($username && $email && $password)
        {
            if($repassword ne $password)
            {
                $c->flash->{error_msg} = "password does not mateched.";
                $c->stash(template => 'auth/register.tt');
                return;
            }
            my $vaild = $email =~ /^[a-z0-9.]+\@[a-z0-9.-]+$/;
            if ($vaild) {
                my $getUser = $c->model('DB::CUser')->search({ email_address => $email });
                if ($getUser == 1) {
                    $c->flash->{error_msg} = "You can't use this email, its already exists.";
                }
                else {

                    my $user = $c->model('DB::CUser')->create({
                        username => $username,
                        email_address    => $email,
                        password => md5_hex($password),
                    });

                    $c->response->redirect($c->uri_for($c->controller('Login')->action_for('index')));
                    return;
                }
            }else{
                $c->flash->{error_msg} = "Please enter valid email.";

            }
        }else{
            $c->flash->{error_msg} = "Empty name,email or password.";
        }
    }
    else{
        $c->flash->{error_msg} = "";
    }

    $c->stash(template => 'auth/register.tt');

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
