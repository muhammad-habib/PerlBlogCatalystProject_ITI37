package Blog::Form::User;
use HTML::FormHandler::Moose;
use namespace::autoclean;
use HTML::FormHandler::Types ('NoSpaces', 'WordChars', 'NotAllDigits' );
use Email::Valid;
extends 'HTML::FormHandler::Model::DBIC';


has '+item_class' => ( default =>'User' );
has_field 'username'=>( type => 'Text',
                        required => 1,
                        messages => { required => 'Please provide a name' }
                    );
has_field 'email' => ( type => 'Email',
                        required => 1,
                         messages => { required => 'Please provide a email' }
                        );
has_field 'password' => ( type => 'Password',
                            apply => [ NoSpaces, WordChars, NotAllDigits ],
                            required => 1,
                            messages => { required => 'Please provide a name' }
                        );
has_field 'submit' => ( type => 'Submit', value => 'Submit' );
__PACKAGE__->meta->make_immutable;
1;