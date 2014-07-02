package DDG::Goodie::RichNav;

use DDG::Goodie;

triggers any => "google", "facebook";
zci is_cached => 1;

handle query_lc => sub {
    my ($text, $rich);

    if    ($_ eq 'google') {
        $text = "Google";
        $rich = <<'EOB';
<form target="_blank" action="https://encrypted.google.com/search"><input name=q value="">&nbsp;<input type=submit value="Search on Google"></form><br>
...or jump to <a target="_blank" href="https://mail.google.com">Gmail</a>, <a target="_blank" href="https://news.google.com">Google News</a>, etc.<br>
EOB
    }
    elsif ($_ eq 'facebook') {
        $text = "Facebook";
        $rich = <<'EOB';
<form target="_blank" action="https://www.facebook.com/search/more/"><input name=q value=""><input type=submit value="Find people on Facebook"></form><br>
...or jump to <a target="_blank" href="https://facebook.com">Facebook News Feed</a>, <a target="_blank" href="https://facebook.com/me">Your Facebook page</a>, etc.<br>
EOB
    }

    return $text, html => $rich;
};

1;
