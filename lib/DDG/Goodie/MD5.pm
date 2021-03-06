package DDG::Goodie::MD5;
# ABSTRACT: Calculate the MD5 digest of a string.

use DDG::Goodie;
use Digest::MD5 qw(md5_base64 md5_hex);
use Encode qw(encode);

zci answer_type => 'md5';
zci is_cached => 1;

primary_example_queries 'md5 digest this!';
secondary_example_queries 'duckduckgo md5',
                          'md5sum the sum of a string';

name 'MD5';
description 'Calculate the MD5 digest of a string.';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/MD5.pm';
category 'transformations';

triggers startend => 'md5', 'md5sum';

my $css = share('style.css')->slurp;

sub html_output {
    my ($md5, $str) = @_;
    return "<style type='text/css'>$css</style>"
          ."<div class='zci--md5'>"
          ."<span class='text--secondary'>MD5 of \"$str\"</span><br/>"
          ."<span class='text--primary'>$md5</span>"
          ."</div>";
}

handle remainder => sub {
    if (/^\s*(.*)\s*$/) {
        # Exit unless a string is found
        return unless $1;
        # The string is encoded to get the utf8 representation instead of
        # perls internal representation of strings, before it's passed to
        # the md5 subroutine.
        my $str = md5_hex (encode "utf8", $1);
        return $str, html => html_output ($str, $1);
    }
};

1;
