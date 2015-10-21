#!/usr/bin/perl

# Parsing job pending

use strict;
use Time::Piece;
use POSIX qw(strftime);

# Time::Piece to create two time objects using the timestamps  

my $before = Time::Piece->strptime("12/07/2015 05:40:00 AM", 
	                               "%d/%m/%Y %I:%M:%S %p");
my $after  = Time::Piece->strptime("12/09/2015 06:00:00 PM",
	                               "%d/%m/%Y %I:%M:%S %p");

print "Before: ".$before."\n";
print "After: ".$after."\n";

# Gap in seconds
my $secdiff = int($after - $before);
print "Seconds between: ".$secdiff."\n";

# Format the result .
my @parts = gmtime($secdiff);
printf ("%4d ->Days  %4d ->Hours %4d ->Min %4d ->Secs\n",
	    @parts[7,2,1,0]);
