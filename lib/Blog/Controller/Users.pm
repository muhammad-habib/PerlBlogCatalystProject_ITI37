package Blog::Controller::Users;
use Blog::Form::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }


sub base :Chained('/') :PathPart('users') :CaptureArgs(0) {
    my ($self, $c) = @_;
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::User'));

    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

sub item : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $user_id ) = @_;
    $c->stash( user => $c->model('DB::User')->find($user_id) );
}

sub create : Chained('base') PathPart('create') Args(0) {
    my ($self, $c ) = @_;

    my $user = $c->model('DB::User')->new_result({});
    return $self->form($c, $user);
}

sub edit : Chained('item') PathPart('edit') Args(0) {
    my ( $self, $c ) = @_;
    return $self->form($c, $c->stash->{user});
}

sub form {
    my ( $self, $c, $user ) = @_;

    my $form = Blog::Form::User->new;
    # Set the template
    $c->stash( template => 'users/form.tt', form => $form );
    $form->process( item => $user, params => $c->req->params );
    return unless $form->validated;
    # Set a status message for the user & return to users list
    $c->response->redirect($c->uri_for($self->action_for('list'),
        {mid => $c->set_status_msg("user created")}));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(users => [$c->model('DB::User')->search({}, {order_by => 'id DESC'})]);
    $c->load_status_msgs;
    $c->stash->{wrapper} = 'site/layouts/sitewrapper.tt';
    $c->stash(template => 'users/list.tt');
}

sub delete : Chained('item') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{user}->delete;
    $c->response->redirect( $c->uri_for($self->action_for('list')) );
}


__PACKAGE__->meta->make_immutable;

1;
