# a2ctl
The official command line interface for apisquared.io. The command-line tool, a2ctl, allows you to run commands against Apisquared to get project artefacts, create new jobs, inspect current jobs, etc.

## Install
Download the install script
```shell
curl -OL https://raw.githubusercontent.com/apisquared/a2ctl/main/install.sh
```
Make the script executable
```shell
chmod +x ./install.sh
```
Install CLI
```shell
./install.sh
```


## Authenticating with apisquared.io
To use ```a2ctl```, you need to authenticate with apisquared by providing a personal access token. You can create one on the [Personal Token](https://console.apisquared.io/admin/tokens) section of the Admin Panel. 

### Setting up your credentials
Your username and personal access token must be set using environment variables.
```shell
APISQUARED_USER=$USERNAME
APISQUARED_TOKEN=$PERSONAL_TOKEN
``` 

### Overriding default API endpoint
If you are running apisquared locally, override default API endpoints using the following environment variables.
```shell
APISQUARED_BDD_ENDPOINT=https://bdd.api.apisquared.io
APISQUARED_CONFORMANCE_ENDPOINT=https://conformance.api.apisquared.io
``` 