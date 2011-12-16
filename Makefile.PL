use inc::Module::Install;
name 'Cirque-Plugin-Authentication-LDAP';
all_from 'lib/Cirque/Plugin/Authentication/LDAP.pm';

requires 'Mouse';
requires 'Net::LDAP';

tests 't/*.t';

test_requires 'Test::More';
WriteAll;
