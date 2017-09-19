### Base OEL image for linux teamcity agents
The image is intended to be used as a base for creating customized linux agents. Therefore there is no entrypoint. To use it as a default linux agent you must modify the Dockerfile add a "USER teamcity" directive and an entrypoint to /tcagent-core.

Available environment attributes:
* `HTTP_PROXY`=<proxy value>
* `HTTPS_PROXY`=<proxy value>
* `NO_PROXY`=<no_proxy values>
* `DOCKER_REGISTRY`=10.88.249.32
* `DOCKER_REGISTRY_PORT`=5000
* `BUILD_SERVER_URL`=<build server uri - defaults to http://localhost:8111>
* `TC_AGENT_NAME`=
* `TC_AGENT_HOME`=defaults /opt/tcbuildagent
* `TC_AGENT_LOG_DIR`=defaults /opt/tcbuildagent/logs
* `TC_USER_HOME`=defaults /scratch/teamcity
* `TEAMCITY_AGENT_MEM_OPTS`=defaults to -Xmx387m -Xss256k - pass any JVM options you need to
# Enable for build properties or environment variables. Syntax should strictly be csv with key=value pairs e.g:
* TC_AGENT_BUILD_PROPERTIES=system.chef.roles.qa=1,system.chef.roles.tcbuildagent=1
* TC_AGENT_ENV_VARIABLES=env.LC_ALL_TEST=test


Developer workflow:
* Modify Dockerfile accordingly
* Modify tcagent init script at bin/tcagent-core
* Modify .env to add or change the value of ENV variables
* Issuing ./build.sh will run the docker-compose build
* Issuing ./rebuild.sh will run docker-compose down, build, up and exec bin/bash the container

#### Additional info

Log files availble at `$TC_AGENT_LOG_DIR`. 

The logs at teamcity-agent.log are also tailed to stdout

All runtime commands run as the teamcity user

IMPORTANT: For additional agent types the core image can be used. In such a case the /tcagent script should always be executed last and in order for the agent to start. So if we need to add a new image e.g tcagent-linux-ruby-2.3, we can inherit the core image and leave an entry point called something like tcagent-linux-ruby. That script should be responsible for any work required for preparing the ruby agent and at the end simply call the core /tcagent script.
