use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Blog';
use Blog::Controller::Post;

ok( request('/post')->is_success, 'Request should succeed' );
done_testing();
