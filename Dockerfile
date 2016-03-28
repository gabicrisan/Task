FROM ubuntu:trusty
ADD box.yml /etc/ansible/playbooks/box.yml
RUN mkdir -p /web

WORKDIR /etc/ansible

RUN apt-get -y update &&  \
    apt-get -y upgrade &&  \
    apt-get -q -y --no-install-recommends install python-yaml \
               python-jinja2 python-httplib2 python-keyczar \
               python-paramiko python-setuptools \
               python-pkg-resources git python-pip &&  \
    mkdir -p /etc/ansible/ &&  \
    pip install ansible &&  \
		echo -e '[local]\nlocalhost' > /etc/ansible/hosts && \
    ansible-playbook /etc/ansible/playbooks/box.yml -c local &&  \

EXPOSE 22 80
 				
