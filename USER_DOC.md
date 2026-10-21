Inception — User Guide

What does this project do?

This project runs a WordPress website using three services:

● NGINX accepts secure HTTPS connections using TLS 1.3.

● WordPress and PHP-FPM run the website and its admin panel.

● MariaDB stores posts, users, and website settings.

Start and stop

Run these commands from the project folder. These examples use  
srcs/docker-compose.yml; change this path if your file has a different name.

Start the project:

docker compose -f srcs/docker-compose.yml up -d --build

Stop the project without deleting its data:

docker compose -f srcs/docker-compose.yml stop

Run the start command again to bring the website back online.

Open the website

● Website: https://ehossain.42.fr

● Admin panel: https://ehossain.42.fr/wp-admin

The domain must point to the virtual machine’s IP address on the computer  
where you open the browser. Log in with your WordPress admin account.  
If you use a self-signed certificate, the browser may show a trust warning.

Usernames and passwords

Check the project’s .env file for account names and settings.  
Password files are listed in the Compose file under secrets.  
Inside a container that uses a secret, it is usually available at  
/run/secrets/<secret_name>.

Keep passwords private and do not commit secret files to Git.  
You can change your WordPress password from your profile in the admin panel.  
Editing a secret file alone does not update an existing account’s password.

Check that everything works

Show the service status:

docker compose -f srcs/docker-compose.yml ps -a

All three services should be running. Open the website and try logging in.  
If something fails, check the recent logs:

docker compose -f srcs/docker-compose.yml logs --tail=50