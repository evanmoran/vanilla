#!/usr/bin/env perl

use 5.012;
use strict;
use warnings;

use Test::More tests => 58;

# Helpers
# --------------------------------------------------------------------

my $vanilla = '../vanilla';
my $userFile = 'fixtures/user.tsv';

sub lines {
  return join("\n", @_) . "\n";
}

# Version
# --------------------------------------------------------------------

my $version = trim(`$vanilla --version`);
my $versionFile = '-1';
$versionFile = $1 if(`cat $vanilla` =~ /vanilla v(\d+.\d+.*)\n/);
ok $versionFile eq $version, 'Version matches file';

# Usage
# --------------------------------------------------------------------

my $usage = /.*vanilla \[options\] argument \[files\.\.\.\].*/;
ok `$vanilla` =~ $usage, 'Command with no arguments shows usage';

# Help
# --------------------------------------------------------------------

my $help = /.*vanilla \[options\] argument \[files\.\.\.\].*/;
ok `$vanilla --help` =~ $help, 'Command with --help shows help';
ok `$vanilla -h` =~ $help, 'Command with -h shows help';

# Grep
# --------------------------------------------------------------------
ok `$vanilla 'echo "#{4}" > #{1}.txt' $userFile` eq lines('echo "Loves fine wine." > Sarah.txt', 'echo "Talks to himself." > Ted.txt', 'echo "Afraid of butterflies." > Britta.txt'), 'execute without executing';

#   trim
# --------------------------------------------------------------------

sub trim
{
  my $str = shift;
  if(defined($str)){
    $str =~ s/^\s+//g;
    $str =~ s/\s+$//g;
  }
  return $str;
}
