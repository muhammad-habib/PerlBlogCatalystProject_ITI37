use utf8;
package Blog::Schema::Result::CUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Blog::Schema::Result::CUser

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<cUsers>

=cut

__PACKAGE__->table("cUsers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 username

  data_type: 'text'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 email_address

  data_type: 'text'
  is_nullable: 1

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=head2 last_name

  data_type: 'text'
  is_nullable: 1

=head2 active

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "username",
  { data_type => "text", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "email_address",
  { data_type => "text", is_nullable => 1 },
  "first_name",
  { data_type => "text", is_nullable => 1 },
  "last_name",
  { data_type => "text", is_nullable => 1 },
  "active",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 c_user_roles

Type: has_many

Related object: L<Blog::Schema::Result::CUserRole>

=cut

__PACKAGE__->has_many(
  "c_user_roles",
  "Blog::Schema::Result::CUserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 posts

Type: has_many

Related object: L<Blog::Schema::Result::Post>

=cut

__PACKAGE__->has_many(
  "posts",
  "Blog::Schema::Result::Post",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 roles

Type: many_to_many

Composing rels: L</c_user_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "c_user_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-03-18 16:22:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:y+0ftQeMwVmdgmTr6tLR4w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
