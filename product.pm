package product;
sub new{
	my $class= shift;
	my $self= {
		_customerId=> shift,
		_productName=> shift,
		_domain=>shift,
		_startDate=> shift,
		_durationMonths=> shift,
	};
	
	print"Customer ID $self->{_customerId}\n";
	print"Customer ID $self->{_productName}\n";
	print"Customer ID $self->{_domain}\n";
	print"Customer ID $self->{_startDate}\n";
	print"Customer ID $self->{_durationMonths}\n";
	bless $self,$class;
	return $self;
}
sub add{
	my $self= shift;
	print "Adding $self->{_customerId}, $self->{_productName}, $self->{_domain}, $self->{_startDate}, $self->{_durationMonths}";
}
sub remove{
	my $self= shift;
	print "Remove $self->{_customerId}, $self->{_productName}, $self->{_domain}";
}