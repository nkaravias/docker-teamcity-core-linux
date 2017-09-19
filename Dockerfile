FROM oraclelinux
MAINTAINER nikolas.karavias@oracle.com

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG BUILD_SERVER_URL 
ARG TC_USER_HOME 
ARG TC_AGENT_HOME

ENV JAVA_HOME=/usr/lib/jvm/jre-openjdk
RUN if [[ ! -z "$HTTP_PROXY" ]] || [[ ! -z "$HTTPS_PROXY" ]]; then echo -e "proxy=$HTTP_PROXY\nproxy=$HTTPS_PROXY" >> /etc/yum.conf; fi

RUN yum install java-1.8.0-openjdk.x86_64 unzip -y && yum clean all
RUN mkdir /scratch && groupadd teamcity && \
useradd -m -d $TC_USER_HOME teamcity -g teamcity && \ 
curl -X GET $BUILD_SERVER_URL/update/buildAgent.zip -o /tmp/buildAgent.zip && \
unzip /tmp/buildAgent.zip -d $TC_AGENT_HOME && \
rm -rf /tmp/buildAgent.zip && \
chown teamcity:teamcity $TC_AGENT_HOME* -R && \
chmod u+x $TC_AGENT_HOME/bin/*.sh

ADD bin/tcagent-core /tcagent-core
ADD conf/buildAgent.properties $TC_AGENT_HOME/conf/

# To use as a base image keep the following lines commented out.
#USER teamcity
#CMD ["/tcagent-core"]
