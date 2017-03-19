package Blog::Controller::Post;
use Moose;
use Blog::Form::Post;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::Post - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

=cut

sub base :Chained('/') :PathPart('posts') :CaptureArgs(0) {
    my ($self, $c) = @_;
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::Post'));

    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
    # If a user doesn't exist, force login
}


sub create : Chained('base') PathPart('create') Args(0) {
    my ($self, $c ) = @_;
    my $post = $c->model('DB::Post')->new_result({});
    return $self->form($c, $post);
}

sub form {
    my ( $self, $c, $post ) = @_;
    my $form = Blog::Form::Post->new;
    # Set the template
    $c->stash( template => 'posts/form.tt', form => $form );

    $c->log->debug(Dumper($c->request->params));
    $c->request->params->{user_id} = $c->user->id;
    $form->process( item => $post, params => $c->req->params );
    return unless $form->validated;
    # Set a status message for the user & return to users list
    $c->response->redirect($c->uri_for($self->action_for('list'),
        {mid => $c->set_status_msg("post created")}));
}

sub item : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $post_id ) = @_;
    $c->stash( post => $c->model('DB::Post')->find($post_id) );
}

sub edit : Chained('item') PathPart('edit') Args(0) {
    my ( $self, $c ) = @_;
    return $self->form($c, $c->stash->{post});
}


sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(posts => [$c->model('DB::Post')->search({}, {order_by => 'id DESC'})]);
    $c->load_status_msgs;
    $c->stash->{wrapper} = 'site/layouts/sitewrapper.tt';
    $c->stash(template => 'posts/list.tt');
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
