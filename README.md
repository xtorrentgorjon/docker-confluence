# docker-confluence
An Atlassian Confluence installation in a docker container which _**does actually work**_.

This image can work smoothly in a Kubernetes environment.


## Setup

Clone repository. Open Dockerfile and edit CONFLUENCE_VERSION to point to latest available. If you need a previous version (this was tested using 6.10), it can be that the URL needs to be changed (e.g. Atlassian using different URL path for old versions). Alternatively, you can just download the binary and change the ADD command to point to your own binary file in your local machine.

## response.varfile

Atlassian applications generate a file named response.varfile when an installation succeeds. This file contains data to run a copy of the same installation again without prompts. You can use the example in this repository or provide your own.

## Running

Build the image:

```
$ docker build confluence .
```

Run the image (you can see debug information with this command, not intended for an actual final deployment):

```
$ docker run -it -p 8090:8090 confluence
```
