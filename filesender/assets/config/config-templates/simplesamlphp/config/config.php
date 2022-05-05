<?php

{TEMPLATE_WARNING}

// Basic configuration that sets up SQL authentication

$config = [

    'baseurlpath' => 'simplesamlphp/',
    'certdir' => 'cert/',
    'loggingdir' => 'log/',
    'datadir' => 'data/',
    'tempdir' => 'tmp/simplesamlphp',
    'technicalcontact_name' => '{SAML_TECHC_NAME}',
    'technicalcontact_email' => '{SAML_TECHC_EMAIL}',
    'timezone' => '{TZ}',
    'secretsalt' => '{SIMPLESAML_SALT}',
    'auth.adminpassword' => '{ADMIN_PASSWORD}',
    'admin.protectindexpage' => false,
    'admin.protectmetadata' => false,
    'admin.checkforupdates' => true,
    'trusted.url.domains' => ['{FILESENDER_TRUSTED_DOMAINS}'],
    'trusted.url.regex' => false,
    'enable.http_post' => false,
    'assertion.allowed_clock_skew' => 180,
    'debug' => [
        'saml' => true,
        'backtraces' => true,
        'validatexml' => false,
    ],
    'showerrors' => true,
    'errorreporting' => true,
    /*
     * Define the minimum log level to log. Available levels:
     * - SimpleSAML\Logger::ERR     No statistics, only errors
     * - SimpleSAML\Logger::WARNING No statistics, only warnings/errors
     * - SimpleSAML\Logger::NOTICE  Statistics and errors
     * - SimpleSAML\Logger::INFO    Verbose logs
     * - SimpleSAML\Logger::DEBUG   Full debug logs - not recommended for production
     */
    'logging.level' => SimpleSAML\Logger::DEBUG,
    'logging.handler' => 'stderr',
    'logging.processname' => 'simplesamlphp',
    'logging.logfile' => 'simplesamlphp.log',
    'statistics.out' => [
        [
            'class' => 'core:Log',
            'level' => 'notice',
        ],
    ],
    'proxy' => null,

    'enable.saml20-idp' => false,
    'enable.shib13-idp' => false,
    'enable.adfs-idp' => false,

    'module.enable' => [
        'admin' => true,
        'core' => true,
        'cas' => true,
        'exampleauth' => false,
        'saml' => true,
        'sqlauth' => true
    ],

    'session.duration' => 8 * (60 * 60), // 8 hours.
    'session.datastore.timeout' => (4 * 60 * 60), // 4 hours
    'session.state.timeout' => (60 * 60), // 1 hour
    'session.cookie.name' => 'SimpleSAMLSessionID',
    'session.cookie.lifetime' => 0,
    'session.cookie.path' => '/',
    'session.cookie.domain' => null,
    'session.cookie.secure' => {SIMPLESAML_SESSION_COOKIE_SECURE},
    'session.cookie.samesite' => \SimpleSAML\Utils\HTTP::canSetSameSiteNone() ? 'None' : 'Lax',
    'session.phpsession.cookiename' => 'SimpleSAML',
    'session.phpsession.savepath' => null,
    'session.phpsession.httponly' => true,
    'session.authtoken.cookiename' => 'SimpleSAMLAuthToken',
    'session.rememberme.enable' => false,
    'session.rememberme.checked' => false,
    'session.rememberme.lifetime' => (14 * 86400),
    'memcache_store.servers' => [
        [
            ['hostname' => 'localhost'],
        ],
    ],
    'memcache_store.prefix' => '',
    'memcache_store.expires' => 36 * (60 * 60), // 36 hours.
    'language' => [
        'priorities' => [
            'no' => ['nb', 'nn', 'en', 'se'],
            'nb' => ['no', 'nn', 'en', 'se'],
            'nn' => ['no', 'nb', 'en', 'se'],
            'se' => ['nb', 'no', 'nn', 'en'],
            'nr' => ['zu', 'en'],
            'nd' => ['zu', 'en'],
            'tw' => ['st', 'en'],
            'nso' => ['st', 'en'],
        ],
    ],

    'language.available' => [
        'en', 'no', 'nn', 'se', 'da', 'de', 'sv', 'fi', 'es', 'ca', 'fr', 'it', 'nl', 'lb',
        'cs', 'sl', 'lt', 'hr', 'hu', 'pl', 'pt', 'pt-br', 'tr', 'ja', 'zh', 'zh-tw', 'ru',
        'et', 'he', 'id', 'sr', 'lv', 'ro', 'eu', 'el', 'af', 'zu', 'xh', 'st',
    ],
    'language.rtl' => ['ar', 'dv', 'fa', 'ur', 'he'],
    'language.default' => '{SIMPLESAML_LANGUAGE_DEFAULT}',

    'language.parameter.name' => 'language',
    'language.parameter.setcookie' => true,

    'language.cookie.name' => 'language',
    'language.cookie.domain' => null,
    'language.cookie.path' => '/',
    'language.cookie.secure' => false,
    'language.cookie.httponly' => false,
    'language.cookie.lifetime' => (60 * 60 * 24 * 900),
    'language.cookie.samesite' => \SimpleSAML\Utils\HTTP::canSetSameSiteNone() ? 'None' : 'Lax',
    'attributes.extradictionary' => null,

    'theme.use' => 'default',
    'template.auto_reload' => false,
    'production' => true,
    'assets' => [
        'caching' => [
            'max_age' => 86400,
            'etag' => false,
        ],
    ],


    'idpdisco.enableremember' => true,
    'idpdisco.rememberchecked' => true,
    'idpdisco.validate' => true,
    'idpdisco.extDiscoveryStorage' => null,
    'idpdisco.layout' => 'dropdown',

    'authproc.idp' => [
        /* Enable the authproc filter below to add URN prefixes to all attributes
        10 => array[
            'class' => 'core:AttributeMap', 'addurnprefix'
        ],
        */
        /* Enable the authproc filter below to automatically generated eduPersonTargetedID.
        20 => 'core:TargetedID',
        */

        // Adopts language from attribute to use in UI
        30 => 'core:LanguageAdaptor',

        45 => [
            'class'         => 'core:StatisticsWithAttribute',
            'attributename' => 'realm',
            'type'          => 'saml20-idp-SSO',
        ],

        /* When called without parameters, it will fallback to filter attributes ‹the old way›
         * by checking the 'attributes' parameter in metadata on IdP hosted and SP remote.
         */
        50 => 'core:AttributeLimit',

        /*
         * Search attribute "distinguishedName" for pattern and replaces if found
         */
        /*
        60 => [
            'class' => 'core:AttributeAlter',
            'pattern' => '/OU=studerende/',
            'replacement' => 'Student',
            'subject' => 'distinguishedName',
            '%replace',
        ],
        */

        /*
         * Consent module is enabled (with no permanent storage, using cookies).
         */
        /*
        90 => [
            'class' => 'consent:Consent',
            'store' => 'consent:Cookie',
            'focus' => 'yes',
            'checked' => true
        ],
        */
        // If language is set in Consent module it will be added as an attribute.
        99 => 'core:LanguageAdaptor',
    ],

    /*
     * Authentication processing filters that will be executed for all SPs
     * Both Shibboleth and SAML 2.0
     */
    'authproc.sp' => [
        /*
        10 => [
            'class' => 'core:AttributeMap', 'removeurnprefix'
        ],
        */

        /*
         * Generate the 'group' attribute populated from other variables, including eduPersonAffiliation.
        60 => [
            'class' => 'core:GenerateGroups', 'eduPersonAffiliation'
        ],
        */
        /*
         * All users will be members of 'users' and 'members'
         */
        /*
        61 => [
            'class' => 'core:AttributeAdd', 'groups' => ['users', 'members']
        ],
        */

        // Adopts language from attribute to use in UI
        90 => 'core:LanguageAdaptor',
    ],



    /**************************
     | METADATA CONFIGURATION |
     **************************/

    'metadatadir' => 'metadata/',

    'metadata.sources' => [
        ['type' => 'flatfile'],
    ],
    'metadata.sign.enable' => false,
    'metadata.sign.privatekey' => null,
    'metadata.sign.privatekey_pass' => null,
    'metadata.sign.certificate' => null,

    'store.type'                    => 'sql',
    'store.sql.dsn'                 => 'sqlite:/opt/simplesamlphp/data/sqlite.db',
    'store.sql.username' => null,
    'store.sql.password' => null,
    'store.sql.prefix' => 'SimpleSAMLphp',
    'store.redis.host' => '{REDIS_HOST}',
    'store.redis.port' => {REDIS_PORT},
    'store.redis.prefix' => 'SimpleSAMLphp',
];
