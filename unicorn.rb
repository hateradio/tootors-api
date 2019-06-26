# /etc/nginx/conf.d/default.conf
# https://www.digitalocean.com/community/tutorials/how-to-deploy-sinatra-based-ruby-web-applications-on-ubuntu-13

# todo change pids

upstream app {
    # Path to Unicorn SOCK file, as defined previously
    server unix:/tmp/unicorn.tootors-api.sock fail_timeout=0;
}

server {


    listen 80;

    # Set the server name, similar to Apache's settings
    server_name localhost;

    # Application root, as defined previously
    root /var/www/tootors-api/public;

    try_files $uri/index.html $uri @app;

    location @app {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://app;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;

}

# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/tootors-api"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www/tootors-api/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/logs/unicorn.log"
# stdout_path "/path/to/logs/unicorn.log"
stderr_path "/var/www/tootors-api/logs/unicorn.log"
stdout_path "/var/www/tootors-api/logs/unicorn.log"

# Unicorn socket
# listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.tootors-api.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
