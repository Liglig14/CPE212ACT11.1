# Start with an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    software-properties-common \
    ansible \
    python3-pymysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Ansible configuration and roles into the container
COPY ansible.cfg /etc/ansible/ansible.cfg
COPY inventory /etc/ansible/inventory
COPY install.yml /etc/ansible/install.yml

# Copy the roles directory into the container
COPY roles /etc/ansible/roles

# Default command to run the Ansible playbook on container start
CMD ["ansible-playbook", "-i", "/etc/ansible/inventory", "/etc/ansible/install.yml"]

