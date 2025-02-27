# Inception

### Objective
The goal of the **Inception** project is to create a secure, fully functional web application using the following technologies:
- **MariaDB**: A database management system for storing and managing application data.
- **Nginx**: A web server to handle HTTP requests and reverse proxy to WordPress.
- **WordPress**: A popular content management system (CMS) to host a website.

### Technologies
- **Docker**: Containerization platform to run applications in isolated environments.
- **Docker Compose**: Tool for defining and running multi-container Docker applications.
- **Nginx**: Web server for reverse proxy and load balancing.
- **MariaDB**: Relational database management system.
- **WordPress**: Content management system to build websites.

## Requirements
1. **Docker** and **Docker Compose** must be installed on your machine.
2. A basic understanding of:
   - Linux system commands and permissions
   - Docker containerization
   - Networking concepts (ports, DNS, etc.)
   - Database management with MariaDB
   - Nginx configuration
   - Setting up WordPress with a database backend

## Project Structure
The project is structured with the following components:
- **Dockerfiles**: Custom configurations for MariaDB, Nginx, and WordPress containers.
- **docker-compose.yml**: Configuration file to define and manage the multi-container setup.
- **nginx.conf**: Nginx configuration file to reverse proxy HTTP requests to the WordPress container.
- **.env**: Environment file to define environment variables such as database credentials, ports, etc.
- **WordPress files**: The source code for WordPress, which will be served by Nginx.
