use strict;
#use warnings;

use DBI;

my $channel;
my $channelnumber;
my $baseimage;

my $dsn = 'DBI:mysql:tv:localhost:3306';
my $db_user_name = 'root';
my $db_password = '';
my ($id, $password);
my $dbh = DBI->connect($dsn, $db_user_name, $db_password);

open( OUTTXT, ">freesat_2019.xml" );
print OUTTXT "<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>\n";
print OUTTXT "<SmartTVChannels>\n";

#my $sth = $dbh->prepare('SELECT a.ChannelID, a.Name, a.Category, b.Base64Image, CASE WHEN b.ImageName IS NULL THEN 0 ELSE 1 END AS ImageFlag FROM freesat a LEFT JOIN base64images b ON a.ImageRef = b.ImageName WHERE a.ChannelID < 402 AND a.ChannelID NOT IN (207,208,209,210,302,303,304,305,306) ORDER BY a.ChannelID LIMIT 1000');

my $sth = $dbh->prepare('SELECT a.ChannelID, a.Name, a.Category, b.Base64Image, CASE WHEN b.ImageName IS NULL THEN 0 ELSE 1 END AS ImageFlag FROM freesat a LEFT JOIN base64images b ON a.ImageRef = b.ImageName ORDER BY a.ChannelID LIMIT 1000');

$sth->execute;
while (my @result = $sth->fetchrow_array) {


	my $channel = $result[1];
	my $channelnumber = $result[0];
	my $baseimage = $result[3];
	my $imageflag = $result[4];	
	print "$channel\n";
	
	if ($imageflag == 0)
	{
	print OUTTXT "  <channel channel_id=\"$channel\" channel_list_number=\"$channelnumber\" />\n";	
	}
	else {
	print OUTTXT "  <channel channel_id=\"$channel\" channel_list_number=\"$channelnumber\">$baseimage\n";
	print OUTTXT "</channel>\n";	
	}
}

print OUTTXT "</SmartTVChannels>";
close(OUTTXT);

$sth->finish;

exit;










	
	
#<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
#<SmartTVChannels>
#<channel channel_id="BBC One" channel_list_number="101">
#xxxxxxxx
#</channel>
#</SmartTVChannels>
