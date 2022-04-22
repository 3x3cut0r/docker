<?php

{TEMPLATE_WARNING}

// Basic configuration that sets up SQL authentication

$config = [
    'admin' => [
        'core:AdminPassword',
    ],

    'filesender-dbauth' => [
      'sqlauth:PasswordVerify',
      'dsn' => '{DB_TYPE}:host={DB_HOST};dbname={DB_NAME}',
      'username' => '{DB_USER}',
      'password' => '{DB_PASSWORD}',
      'query' => 'SELECT saml_user_identification_uid AS uid, 
		         saml_user_identification_uid AS email, 
		         passwordhash, 
			 created, 
                         \'uid\' AS eduPersonTargetedID 
		  FROM Authentications 
                  WHERE saml_user_identification_uid = :username ',
    ],
];
