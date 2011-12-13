Cirque::Plugin->new(
    name => "API-Authentication-LDAP",
    on_register => sub {
        warn "api-authentication-ldap was loaded";
    },
);
