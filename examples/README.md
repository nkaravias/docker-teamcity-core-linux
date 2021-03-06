### Adding a new build agent type off of the base agent image

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
* Modify Dockerfile accordingly for the new use case. The USER=teamcity directive must be applied
* Add a startup script at bin/ and have the script invoke /tcagent-core at the very end
* Modify .env to add or change the value of ENV variables
* Issuing ./build.sh will run the docker-compose build
* Issuing ./rebuild.sh will run docker-compose down, build, up and exec bin/bash the container
