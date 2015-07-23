# -*- coding:utf-8; mode:CPerl -*-
use 5.8.0; use strict; use warnings; use Test; use utf8;
print q[# //Time-stamp: "2014-06-17 18:26:42 MDT sburke@cpan.org"], "\n";

BEGIN {plan tests => 3;}


print "# Let's just see if a bare 'use Text::Unidecode' works:\n";

ok 1;

use Text::Unidecode;

print "# We just loaded Unidecode version: ",
  $Text::Unidecode::VERSION || "?", "\n";

ok "a", unidecode("a"); # sanity

print "# Bye:\n";
ok 1;
