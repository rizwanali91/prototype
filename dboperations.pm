
package dboperations; 
use DBI;  
use strict;  
use warnings;
use Time::Piece;
use POSIX qw(strftime);
use Time::Seconds;

sub new {
	my $class= shift;
	my $driver = "SQLite";  
	my $database = "prototype.db";  
	my $dsn      = "DBI:$driver:dbname=$database";  
	my $user     = "";  
	my $password = "";  
	my $dbh = DBI->connect($dsn, $user, $password, {  
	   #PrintError       => 0,  
	   RaiseError       => 1,  
	   AutoCommit       => 1,  
	  # FetchHashKeyName => 'NAME_lc',  
	})or die $DBI::errstr;  
	print "Opened database successfully\n";
	my $self = { dbh => $dbh};
	bless $self,$class;
	return $self;
}

sub fetch{
	my $self= shift;
	my $sth = $self->{ dbh }->prepare( "select * from mailschedule order by EMAILDATE")or die $DBI::errstr;
	my $rv = $sth->execute() or die $DBI::errstr;
	print "Test\n";
	if($rv < 0) {
	   print $DBI::errstr;
	}
	
	while(my @row = $sth->fetchrow_array()) {
=begin
	      print "CUSTOMERID = ". $row[0] . "\n";
	      print "PRODUCTNAME = ". $row[1] ."\n";
	      print "DOMAIN = ". $row[2] ."\n";
	      print "Email Date =  ". $row[3] ."\n";
=cut
	      print " ". $row[0] ." ". $row[1] ." ". $row[2] ." ". $row[3] ."\n";
	}
	print "Operation done successfully\n";

} 

sub insertschedule{
	my $self= shift;
	my ($id, $productname, $domain, $maildate) = @_;
	
	my $sth = $self->{ dbh }->prepare("insert into mailschedule values(?,?,?,?)")or die DBI::errstr;
	my $rv = $sth->execute($id, $productname, $domain, $maildate) or die $DBI::errstr;
	print "Test\n";
	if($rv < 0) {
	   my $value =$DBI::errstr;
	   print "Error is: $value";
	}
}
	

sub insert{
	my $self= shift;
	my ($id, $productname, $domain, $startdate, $duration) = @_;
	
	
	my $sth = $self->{ dbh }->prepare("insert into product values(?,?,?,?,?)")or die $DBI::errstr;
	my $rv = $sth->execute($id, $productname, $domain, $startdate, $duration) or die $DBI::errstr;
	print "Test\n";
	if($rv < 0) {
	   my $value =$DBI::errstr;
	   print "Error is: $value";
	   }
	   my $t1 = Time::Piece->strptime($startdate, "%Y-%m-%d");
	   my $t2 = Time::Piece->strptime($startdate, "%Y-%m-%d");
	   print "time $t1\n $t2\n";
	   my $maildate1= $t1->strftime("%Y-%m-%d"); 
	   my $maildate2= $t2->strftime("%Y-%m-%d"); 
	   my $i=0;
	   for($i=0; $i<$duration;$i+=1)
		   {
			$t2+= ONE_MONTH;
		   }
	   
	   my $dbop= dboperations->new();
	   if($productname eq "domain")
	   {
		   
		   $t2-= ONE_DAY;
		   $t2-= ONE_DAY;
		   $maildate2= $t2->strftime("%Y-%m-%d"); 
		   $dbop->insertschedule($id, $productname, $domain, $maildate2);
		   
	   }
	   else
	   {
	   	   if($productname eq "hosting")
	   	   {
	   	   	$t1+= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
		        $maildate1= $t1->strftime("%Y-%m-%d"); 
			$maildate2= $t2->strftime("%Y-%m-%d"); 
			$dbop->insertschedule($id, $productname, $domain, $maildate1);
			$dbop->insertschedule($id, $productname, $domain, $maildate2);
		   }elsif($productname eq "pdomain")
		   {
		   	
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t1= $t2;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
	   	   	$t2-= ONE_DAY;
			$maildate1= $t1->strftime("%Y-%m-%d"); 
			$maildate2= $t2->strftime("%Y-%m-%d");
			$dbop->insertschedule($id, $productname, $domain, $maildate1);
			$dbop->insertschedule($id, $productname, $domain, $maildate2);
		    }
	    }
	 
		
		

	$self->{ dbh }->disconnect; 
}

sub remove{
	my $self= shift;
	my ($id, $productname, $domain) = @_;
	my $sth = $self->{ dbh }->prepare("delete from product where customerid=? and productname=? and domain=?")or die $DBI::errstr;
	my $rv = $sth->execute($id, $productname, $domain) or die $DBI::errstr;
	print "Deleted from product \n";
	if($rv < 0) {
	   my $value =$DBI::errstr;
	   print "Error is: $value";
	}
	$sth = $self->{ dbh }->prepare("delete from mailschedule where customerid=? and productname=? and domain=?")or die $DBI::errstr;
	$rv = $sth->execute($id, $productname, $domain) or die $DBI::errstr;
	print "Deleted from mail schedule \n";
	if($rv < 0) {
	   my $value =$DBI::errstr;
	   print "Error is: $value";
	}
}
	
my $dbop= dboperations->new();

#Fetch Email schedule list
$dbop->fetch();

#Remove product
#$dbop->remove('3791er','pdomain','domaine');

#Add new product
$dbop->insert('3713er','hosting','erqd.net','2021-12-01','4');
