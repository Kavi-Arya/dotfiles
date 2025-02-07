#!/usr/bin/perl
use strict;
use warnings;

# Get player status
my $status = `playerctl status`;
chomp($status);

# Get title and truncate if necessary
my $title = `playerctl metadata --format '{{title}}' 2>/dev/null`;
chomp($title);
$title = substr($title, 0, 40) . '...' if length($title) > 40;

# Get artist and truncate if necessary
my $artist = `playerctl metadata --format '{{artist}}' 2>/dev/null`;
chomp($artist);
$artist = substr($artist, 0, 40) . '...' if length($artist) > 40;

# Output based on status
if ($status =~ /Playing/) {
    print "$artist: $title\n";
} else {
    print "~\n";
}
