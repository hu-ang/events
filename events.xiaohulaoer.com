server {
    listen 80;
    listen [::]:80;

    # TODO: This should be your server name.
    server_name events.xiaohulaoer.com;

    location / {
        proxy_pass http://localhost:4567;
    }

    location /socket {
        proxy_pass http://localhost:4567;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";	 	 
    }
}
