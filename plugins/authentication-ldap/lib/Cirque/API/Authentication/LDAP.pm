package Cirque::API::Authentication::LDAP;
use Cirque::Pragmas;
use Mouse;
use Net::LDAP;
use Net::LDAP::Entry;

extends 'Cirque::API::Authentication::External';

has host => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has port => (
    is => 'ro',
    isa => 'Int',
    default => 389,
    required => 1,
);

has dn => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has password => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has search_base => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has default_domain => (
    is => 'ro',
);

sub autocomplete_email {
    my ($self, $email) = @_;

    if (! $email) {
        return;
    }

    my $default_domain = $self->default_domain;
    if ( $email !~ m{\@} ) {
        $email = "$email\@$default_domain";
    }
    return $email;
}

sub authenticate {
    my ($self, $args) = @_;

    my $ldap = $self->ldap_connect( $self->dn, $self->password );
    if (! $ldap) {
        Carp::croak( sprintf "Initial authentication to access LDAP failed. error: %s", do{ $@ ? $@ : '' } );
    }

    my $email = $self->autocomplete_email( $args->{email} );

    my $result = $ldap->search(
        base => $self->search_base,
        filter => "(MAIL=$email)",
    );
    if (! $result) {
        warn "could not find LDAP result for $email";
        return ();
    }

    my $entry = $result->pop_entry();
    if (! $entry) {
        warn "could not find entry from LDAP result for $email";
        return ();
    }

    my $newldap = $self->ldap_connect( $entry->dn, $args->{password} );
    if (! $newldap) {
        warn "could not authenticate $email with given password";
        return();
    }
    my %member = (
        last_name    => $entry->get_value( "sn" )             || undef,
        first_name   => $entry->get_value( "givenName" )      || undef,
        internal_id  => $entry->get_value( "cn" )             || undef,
        account_id   => $entry->get_value( "SAMACCOUNTNAME" ) || undef,
        email        => $entry->get_value( "email" )          || $email,
        author       => $entry->get_value( "email" )          || $email,
    );
    $self->initialize_member( \%member );

    return \%member;
}

sub ldap_connect {
    my ($self, $dn, $password) = @_;

    my $ldap = Net::LDAP->new( $self->host, port => $self->port );
    return unless $ldap;

    my $result = $ldap->bind( $dn, password => $password );

    return $result->code == 0 ? $ldap : ();
}

no Mouse;

1;
