# heroku-config-rollback

Allow roll back of values of the environment variables to a past release.


## Installation

Add the heroku gem plugin:

    $ heroku plugins:install git://github.com/guilleiguaran/heroku-config-rollback.git
    heroku-config-rollback installed

## Usage

The `heroku config:rollback` command can be used to restore the config variables without roll back full release (app code).
Consider the next full example of the flow:


    % heroku config
    === tranquil-reaches-9301 Config Vars
    DATABASE_URL:               postgres://mvvbnhxqfddgrb:z6KEe_JRcuAqMIaaWlsCcXfHwq@ec2-54-197-238-239.compute-1.amazonaws.com:5432/d32puifu1387tt
    HEROKU_POSTGRESQL_CYAN_URL: postgres://mvvbnhxqfddgrb:z6KEe_JRcuAqMIaaWlsCcXfHwq@ec2-54-197-238-239.compute-1.amazonaws.com:5432/d32puifu1387tt
    
    % heroku config:set RACK_ENV=development
    Setting config vars and restarting tranquil-reaches-9301... done, v6
    
    % heroku config:unset DATABASE_URL
    Unsetting DATABASE_URL and restarting tranquil-reaches-9301... done, v7
    
    % heroku config
    === tranquil-reaches-9301 Config Vars
    HEROKU_POSTGRESQL_CYAN_URL: postgres://mvvbnhxqfddgrb:z6KEe_JRcuAqMIaaWlsCcXfHwq@ec2-54-197-238-239.compute-1.amazonaws.com:5432/d32puifu1387tt
    RACK_ENV:                   development
    
    % heroku config:rollback v5
    Rolling back tranquil-reaches-9301 config vars to v5... done

    % heroku config
    === tranquil-reaches-9301 Config Vars
    DATABASE_URL:               postgres://mvvbnhxqfddgrb:z6KEe_JRcuAqMIaaWlsCcXfHwq@ec2-54-197-238-239.compute-1.amazonaws.com:5432/d32puifu1387tt
    HEROKU_POSTGRESQL_CYAN_URL: postgres://mvvbnhxqfddgrb:z6KEe_JRcuAqMIaaWlsCcXfHwq@ec2-54-197-238-239.compute-1.amazonaws.com:5432/d32puifu1387tt

## License

MIT License

## Author

Guillermo Iguaran <guilleiguaran@gmail.com>
