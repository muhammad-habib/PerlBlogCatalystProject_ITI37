package Blog::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';
__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'wrapper.tt',
);

=head1 NAME

Blog::View::HTML - TT View for Blog

=head1 DESCRIPTION

TT View for Blog.

=head1 SEE ALSO

L<Blog>

=head1 AUTHOR

Habib,ali,mohamed

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
