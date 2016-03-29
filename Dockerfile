FROM centos:centos6
ADD box.yml /etc/ansible/playbooks/box.yml
RUN mkdir -p /web

RUN yum -y install epel-release
RUN yum -y install ansible
RUN echo "localhost ansible_connection=local" > /etc/ansible/hosts
RUN sed -i '/sudo: yes/d' /etc/ansible/playbooks/box.yml
RUN ansible-playbook /etc/ansible/playbooks/box.yml
 				
