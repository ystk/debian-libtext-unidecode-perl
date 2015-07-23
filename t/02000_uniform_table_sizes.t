# -*- coding:utf-8; mode:CPerl -*-
use 5.8.0;
use Test; use strict; use warnings;
my @Bank_Numbers;
BEGIN { @Bank_Numbers = (1 .. 0xFF); }
BEGIN {plan tests => 2 + 2 * @Bank_Numbers};
ok 1;
print q[# (Time-stamp: "2014-07-04 02:16:30 MDT sburke@cpan.org")], "\n";
print "# Loading all modules and checking fullness of each table.\n";

use Text::Unidecode;
print "# Text::Unidecode version $Text::Unidecode::VERSION\n";

$| = 1;

#
#  For each iteration:
#   1:  It's true that "defined unidecode $char"
#   2:  We've got an arrayref
#   3:  Arrayref is the right size


# NOTE: this WILL have to change once we support surrogates


Bank:
foreach my $banknum ( @Bank_Numbers ) {
  my $charnum = $banknum << 8;
  my $char = chr( $charnum );

  print "# About to test banknum $banknum via charnum $charnum\:\n";

  ok defined unidecode $char;
  my $bank_arrayref = $Text::Unidecode::Char[$banknum];

  unless(defined $bank_arrayref) {
    # Gotta fake out the test-harness's count for this file.
    ok 0;
    print "# No \$Text::Unidecode::Char[$banknum] in memory?!\n";
    next Bank;
  }
  
  ok( ref($bank_arrayref), 'ARRAY' ) or next Bank;

  my $bank_name = "Bank_0x%02x";

  # Let's work up a diagnostic describing this file.
  my $diag = "That's $bank_name";


  my $package_path = sprintf "Text/Unidecode/xx%02x.pm", $banknum;

  my $bank_file = $INC{ $package_path } || '';

  if($bank_file) {
    $diag .= " ";
    if(-e $bank_file) {
      $diag .= " of size " . (-s $bank_file) . " bytes.";
    } else {
      $diag .= " (but can't find that file on disk!)";
    }
  } else {
    $diag .= "-- But there is no $bank_file in \%INC!)";
  }


  #ok @{   }, 256,  $diag;
}

#print map "$_ : $INC{$_}\n", sort keys %INC;

sub diag {
  my($banknum);
}

print "# Bye:\n";
ok 1;
#End
