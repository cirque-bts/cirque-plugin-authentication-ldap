{
##
## config.pl
## LDAP認証プラグイン　動作設定ファイル
##

# -------------------------------------------------------------------------------------------------
# API::Authentication - 認証方式の設定
#
# typeに'LDAP'を指定することで、認証方式にLDAPを使用します。
#
    'API::Authentication' => {
        type => 'LDAP',
    },

# -------------------------------------------------------------------------------------------------
# API::Authentication::LDAP - LDAP認証の詳細設定
#
# LDAP認証に用いるLDAPサーバの指定を行います。
# host: 認証に使うLDAPサーバのホスト名
# port: LDAPサーバのバインドポート番号
# dn: LDAPサーバ接続時の識別名(DN)
# password: LDAPサーバ接続時のパスワード
# search_base: 認証ユーザを検索するためのベースDN
# default_domain: メールアドレス自動補完用のベースとなるドメイン
#
#    'API::Authentication::LDAP' => {
#        host => "ldap.example.com",
#        port => 389,
#        dn => "cn=example,dc=cirque",
#        password => "ldapPassword",
#        search_base => "ou=CIRQUE,dc=example",
#        default_domain => "example.com",
#    },

};
