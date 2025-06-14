<?php

return [

    'paths' => ['api/*','sanctum/csrf-cookie'],

    'allowed_methods' => ['*'],

    'allowed_origins' =>  ['http://localhost:56503', 'http://localhost:8000'],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => false,

];
