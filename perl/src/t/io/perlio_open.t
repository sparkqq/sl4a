#!./perl

BEGIN {
    chdir 't' if -d 't';
    @INC = '../lib';
    if ($ENV{PERL_CORE_MINITEST}) {
	print "1..0 # Skip: no Fcntl under miniperl\n";
	exit 0;
    }
    unless (find PerlIO::Layer 'perlio') {
	print "1..0 # Skip: not perlio\n";
	exit 0;
    }
    use Config;
    unless (" $Config{extensions} " =~ / Fcntl /) {
	print "1..0 # Skip: no Fcntl (how did you get this far?)\n";
	exit 0;
    }
    require './test.pl';
}

use strict;
use warnings;

plan tests => 6;

use Fcntl qw(:seek);

{
    ok((open my $fh, "+>", undef), "open my \$fh, '+>', undef");
    print $fh "the right write stuff";
    ok(seek($fh, 0, SEEK_SET), "seek to zero");
    my $data = <$fh>;
    is($data, "the right write stuff", "found the right stuff");
}

{
    ok((open my $fh, "+<", undef), "open my \$fh, '+<', undef");
    print $fh "the right read stuff";
    ok(seek($fh, 0, SEEK_SET), "seek to zero");
    my $data = <$fh>;
    is($data, "the right read stuff", "found the right stuff");
}




