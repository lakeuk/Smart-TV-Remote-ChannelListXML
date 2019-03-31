use strict;
#use warnings;

use DBI;
use MIME::Base64;
use File::Slurp;

my $driver = 'SQLite';
my $database = "smartremote.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

#variables
my $imagefile;
my $buf;
my $imgencode;

print "starting...\n";

my $path  = "tvlogos";      # Which path was I asked to list?
my(@current_dir_list);  # *This* directory's entries
  
opendir DIR, $path or warn "Can't open $path\n";
  @current_dir_list = readdir DIR;    # Get complete list of "top-level" names
closedir (DIR);    

my $size = @current_dir_list;

$dbh->do("delete from base64images;") or die "Huston we have a problem: Can't insert record\n";

foreach $imagefile (@current_dir_list)
{
$size--;


my @col_split = split( /\./ ,$imagefile);
my $filename="$col_split[0]";
my $filetype="$col_split[1]";

if ($imagefile =~ /.png$/i)
{
my $infile  = "\".\\$path\\$imagefile\"";
my $outfile = "\".\\$path\\$imagefile.b64\"";
system(".\\base64\\b64 -e $infile > $outfile");

my $file = "$path\\$imagefile.b64";
my $b24text = read_file("$file");
#print "$infile\n";
print "$filename\n";

$dbh->do("INSERT INTO base64images(ImageName,ImageType,Base64Image,ImageSource) VALUES ('$filename','$filetype','$b24text','mediaportal');") or die "Huston we have a problem: Can't insert record\n";
unlink "$path\\$imagefile.b64"; #delete b64 file
}

}

$dbh->disconnect();

exit;

#INSERT INTO base64images(
#   ImageID
#  ,ImageName
#  ,ImageType
#  ,Base64Image
#  ,ImageSource
#) VALUES (
#   0   -- ImageID - IN int(11)
#  ,''  -- ImageName - IN varchar(200)
#  ,''  -- ImageType - IN varchar(10)
#  ,''  -- Base64Image - IN varchar(2000)
#  ,''  -- ImageSource - IN varchar(200)
#)