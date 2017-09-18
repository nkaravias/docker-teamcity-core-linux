Base OEL image for linux teamcity agents

Available environment attributes:
*HTTP_PROXY=<proxy value>
*HTTPS_PROXY=<proxy value>
*DOCKER_REGISTRY=10.88.249.32
*DOCKER_REGISTRY_PORT=5000
*BUILD_SERVER_URL=http://build-eloqua.us.oracle.com
*TC_AGENT_NAME=
*TC_AGENT_HOME=defaults /opt/tcbuildagent
*TC_AGENT_LOG_DIR=defaults /opt/tcbuildagent/logs
*TC_USER_HOME=defaults /scratch/teamcity
*TEAMCITY_AGENT_MEM_OPTS=defaults -Xmx387m -Xss256k


Log files availble at $TC_AGENT_LOG_DIR. The logs at teamcity-agent.log are also tailed to stdout

Developer workflow:
* Modify Dockerfile accordingly
* Modify tcagent init script at bin/tcagent-core
* Modify .env to add or change the value of ENV variables
* Issuing ./build.sh will run the docker-compose build 
* Issuing ./rebuild.sh will run docker-compose down, build, up and exec bin/bash the container 
* All runtime commands run as the teamcity user
