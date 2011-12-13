package Cirque::Plugin::Authentication::LDAP;
use strict;
use warnings;
our $VERSION = '0.01';

1;
__END__

=head1 NAME

Cirque::Plugin::Authentication::LDAP - Authentication-backend for Cirque

=head1 SYNOPSIS

    $ ln -s cirque-plugin-authentication-ldap/plugins/authentication-ldap path/to/cirque/plugins/
    $ path/to/cirque/bin/cirqued

=head1 DESCRIPTION

Cirque::Plugin::Authentication::LDAP is an authentication-backend for cirque.

=head1 Configuration

See plugins/authentication-ldap/etc/config.pl

=head1 SEE ALSO

plugins/authentication-ldap/etc/config.pl

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
