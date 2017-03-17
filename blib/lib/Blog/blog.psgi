use strict;
use warnings;

use Blog;

my $app = Blog->apply_default_middlewares(Blog->psgi_app);
$app;

