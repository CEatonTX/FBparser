#!/usr/bin/perl\
#
# FBswparser Version 0.01
# Chris Eaton
# This is intended for Law Enforcement use but there is nothing here
# that is confidential...
#
# I do not even pretend to be great at this. Suggestions for improvement are appreciated.
#
# Contact chriseatontx@gmail.com

use v5.22.1;                           #enable features
use strict;                            #always do this
use warnings;                          #always do this

my $filename= 'unified_messages/index.html';
my $fh= undef; my $NumberOfUIDs= undef; my $found= undef;my $countlines= 0;
my $countuids= 0; my $countlineuids= 0;my $numfinds= 0; my @uids= undef;
my $uid= undef; my $x= undef; my $y- undef; my @uidsinline= undef;
my $count = undef;

open ($fh, '<', $filename)
  or die "cannot open '$filename error: $!";

say "Processing \"$filename...\"", "\n";

while ( $_ = readline($fh) ) {        #Shorthand for: while ($_ = readline($fh)) {
  $countlines++;      #Keep track of how many lines we read in this file
  $countlineuids = 1;                 #Reset this during each loop.

  @uidsinline = /id=(100\d{12})/g;
  if (@uidsinline) {      #if a UID found then do this
    foreach $x (@uidsinline) { #Count how many UIDs there are
      $countuids++;      #Keep track of total UIDs
      $countlineuids++; #count the number of UIDs in this line only
    }

    if ($countlineuids > 1) {say "I found $countlineuids UIDs in line $countlines";}
      else {say "I found one UID in line $countlines";
    }

    say "Now processing each UID in line $countlines:\n";        #this is for debuging
    say "size of array \@uidsinline:", scalar(@uidsinline);

    $count = 0;
    foreach my $x (@uidsinline) {
      $count++;
      say "working on UID $x";
      say "checking to see if UID $x is in the array \@uids";
      if ($x) {say "x=", $x;}
      say "\$count=", $count;
    }
  }
}
say "Found $countuids UIDs in $countlines lines in \"$filename\"";
die "Could not find any UID's " unless($fh); #code dies with nice error
