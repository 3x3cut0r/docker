<?php

{TEMPLATE_WARNING}

// Basic configuration that sets up SQL authentication

$config = [

    'admin' => [
        'core:AdminPassword'
    ],

    'default-sp' => [
        'saml:SP',
        'entityID' => null,
        'idp' => null,
        'discoURL' => null
    ],

    'filesender-dbauth' => [
        'sqlauth:PasswordVerify',
        'dsn' => '{DB_TYPE}:host={DB_HOST};dbname={DB_NAME}',
        'username' => '{DB_USER}',
        'password' => '{DB_PASSWORD}',
        'query' => 'SELECT  saml_user_identification_uid AS uid,
                            saml_user_identification_uid AS email,
                            passwordhash,
                            created,
                            \'uid\'
                    AS      eduPersonTargetedID
		            FROM    Authentications
                    WHERE   saml_user_identification_uid = :username '
    ],

    'example-cas' => [
        'cas:CAS',
        'cas' => [
            'login' => 'https://webauth.arizona.edu/webauth/login',
            'validate' => null,
            'logout' => null
        ]
    ],

    'ldap' => [
        'servers' => 'ldaps://ldap.arizona.edu:636/',
        'enable_tls' => true,
        'searchbase' => 'ou=people,dc=org,dc=com',
        'searchattributes' => 'uid',
        'attributes' => array('uid','cn'),
        'priv_user_dn' => 'cn=simplesamlphp,ou=applications,dc=org,dc=com',
        'priv_user_pw' => 'password'
    ]

];
