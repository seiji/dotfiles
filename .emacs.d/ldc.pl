#!/usr/local/bin/perl
use strict;
use warnings;

use WWW::Mechanize;
use utf8;
use Encode;

my $url = $ARGV[0];
die "no url" unless $url;

# ID/Password
my $username = 'xxxxx',
my $password = 'xxxxx',

# WWW:Mechanize スタート
#
my $mech = WWW::Mechanize->new();
my $mechurl = "http://clip.livedoor.com/clip/add";

$mech->get($mechurl);

# $mechurl から http://member.livedoor.com/login/ に遷移
# ログインフォーム入力

$mech -> submit_form (
  form_name=>'loginForm',
  fields => {
    livedoor_id => $username,
    password    => $password,
  },
);

$mechurl = "http://clip.livedoor.com/clip/add?link=$url";
$mech->get($mechurl);

if ($mech->uri() =~m|^http://clip.livedoor.com/clip/add|) {
	$mech -> form_name('clip');
}
if ($mech->uri() =~m|^http://clip.livedoor.com/clip/edit|) {
	$mech -> form_name('edit_form');
}
$mech -> submit();
