use strict;
#use warnings;

use DBI;
use MIME::Base64;
use File::Slurp;

my $dsn = 'DBI:mysql:tv:localhost:3306';
my $db_user_name = 'root';
my $db_password = '';
my ($id, $password);
my $dbh = DBI->connect($dsn, $db_user_name, $db_password);

#variables
my $imagefile;
my $buf;
my $imgencode;

print "starting...\n";

my $path  = "E:/files/dave/smart_remote/perl/tvlogos";      # Which path was I asked to list?
my(@current_dir_list);  # *This* directory's entries
  
opendir DIR, $path or warn "Can't open $path\n";
  @current_dir_list = readdir DIR;    # Get complete list of "top-level" names
closedir (DIR);    

my $size = @current_dir_list;

$dbh->do("truncate table tv.base64images;") or die "Huston we have a problem: Can't insert record\n";

foreach $imagefile (@current_dir_list)
{
$size--;


my @col_split = split( /\./ ,$imagefile);
my $filename="$col_split[0]";
my $filetype="$col_split[1]";

#print "$imagefile - $filename - $filetype\n";

if ($imagefile =~ /.png$/i)
{
system("\"E:\\files\\dave\\smart_remote\\base64\\encb64.exe\" \"$path\\$imagefile\"");
my $file = "$path\\$imagefile.b64";

my $b24text = read_file($file);

print "$filename\n";

#$dbh->do("INSERT INTO tv.base64images(ImageID,ImageName,ImageType,Base64Image,ImageSource) VALUES ($size,'$filename','$filetype','$b24text','mediaportal');") or die "Huston we have a problem: Can't insert record\n";
$dbh->do("INSERT INTO tv.base64images(ImageName,ImageType,Base64Image,ImageSource) VALUES ('$filename','$filetype','$b24text','mediaportal');") or die "Huston we have a problem: Can't insert record\n";
unlink "$path\\$imagefile.b64"; #delete b64 file
}

}

$dbh->disconnect();

exit;










#INSERT INTO tv.base64images(
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