# ks_timestamp.pl
#
# prints irssi timestamps in kiloseconds
#

use Irssi;
use strict;

use vars qw($VERSION %IRSSI);

$VERSION="0.1";
%IRSSI = (
	author		=> 'Heikki Mehtänen',
	contact		=> 'heikki@mehtanen.fi',
	name		=> 'ks_timestamp',
	description	=> 'Prints the timestamp in kiloseconds',
	license		=> 'GPL',
);

my $old_timestamp = Irssi::settings_get_str('timestamp_format');

sub to_kiloseconds {
	my ($sec,$min,$hour) = localtime();

	# calculate kiloseconds
	my $ks = (($hour*60*60)+($min*60)+$sec)/1000;	

	# make it 3 decimals
	$ks = sprintf("%.3f",$ks);
	Irssi::command("^set timestamp_format $ks");
}

sub _unload {
	my ($script,$server,$witem) = @_;
	Irssi::command("^set timestamp_format $old_timestamp");
}

# timeout + unload
Irssi::timeout_add(1000, 'to_kiloseconds', undef);
Irssi::signal_add_first('command script unload', '_unload');
