package schedule;
sub new{
	my $class= shift;
	my $self= {
		_customerId=> shift,
		_productName=> shift,
		_domain=>shift,
		_emailDate=> shift,
	};
	
	print"Customer ID $self->{_customerId}\n";
	print"Product Name $self->{_productName}\n";
	print"Domain $self->{_domain}\n";
	print"Email Date $self->{_emailDate}\n";
	bless $self,$class;
	return $self;
}
sub add{
	my $self= shift;
	print "Adding $self->{_customerId}, $self->{_productName}, $self->{_domain}, $self->{_emailDate}\n";
}
sub remove{
	my $self= shift;
	print "Removing $self->{_customerId}, $self->{_productName}, $self->{_domain}\n";
}