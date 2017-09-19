ARG DOCKER_REGISTRY
ARG DOCKER_REGISTRY_PORT
FROM $DOCKER_REGISTRY:$DOCKER_REGISTRY_PORT/eloqua/skynet/tcagent-core-oel7
MAINTAINER nikolas.karavias@oracle.com

ARG HTTP_PROXY
ARG HTTPS_PROXY
RUN if [[ ! -z "$HTTP_PROXY" ]] || [[ ! -z "$HTTPS_PROXY" ]]; then echo -e "proxy=$HTTP_PROXY\nproxy=$HTTPS_PROXY" >> /etc/yum.conf; fi

RUN yum install -y which curl tar sudo libyaml-devel --enablerepo=ol7_optional_latest \
&& gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
&& \curl -L https://get.rvm.io | bash -s stable \
&& source /etc/profile.d/rvm.sh \
&& /bin/bash -l -c "rvm requirements" \
&& yum clean all \
&& /bin/bash -l -c "rvm cleanup all"

ADD bin/tcagent-rvm /tcagent-rvm

USER teamcity
CMD ["/tcagent-rvm"]
