#!/usr/bin/env bash
# This is a line of text
sudo apt update -y
sudo apt install -y nginx
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch /data/web_static/releases/test/index.html
sudo sh -c 'echo "<body>Hello World</body>" > /data/web_static/releases/test/index.html'
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo sh -c "echo 'server {
		listen 80 default_server;
		add_header X-Served-By $(hostname);
		listen [::]:80 default_server;
		location /hbnb_static {
			alias /data/web_static/current;
		}
		# SSL configuration
		#
		# listen 443 ssl default_server;
		# listen [::]:443 ssl default_server;
		#
		# Note: You should disable gzip for SSL traffic.
		# See: https://bugs.debian.org/773332
		#
		# Read up on ssl_ciphers to ensure a secure configuration.
		# See: https://bugs.debian.org/765782
		#
		# Self signed certs generated by the ssl-cert package
		#
		# include snippets/snakeoil.conf;
		root /var/www/html;
		# Add index.php to the list if you are using PHP
		index index.html index.htm index.nginx-debian.html;
		server_name _;
		location /redirect_me {
			return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
		}
}' > /etc/nginx/sites-available/default"
sudo service nginx restart