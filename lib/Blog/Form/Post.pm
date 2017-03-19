
package Blog::Form::Post;
use HTML::FormHandler::Moose;
use namespace::autoclean;
use HTML::FormHandler::Types ('NoSpaces', 'WordChars', 'NotAllDigits' );
use Email::Valid;

extends 'HTML::FormHandler::Model::DBIC';


has '+item_class' => ( default =>'Post' );
has_field 'user_id'=>( type => 'Hidden',
    );
has_field 'title'=>( type => 'Text',
        required => 1,
        messages => { required => 'Please provide a title' },
    );
has_field 'text' => ( type => 'TextArea',
        required => 1,
        messages => { required => 'Please provide a email' }
    );
has_field 'submit' => ( type => 'Submit', value => 'Submit' );
__PACKAGE__->meta->make_immutable;
1;