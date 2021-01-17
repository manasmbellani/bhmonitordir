# bhmonitordir
Script to monitor new lines/content added to files within a directory or individual files

## Setup
For Mac or Linux, nothing required by default. Script mainly uses find/grep to operate.

Via docker, build the docker as follows:
```
docker build -t bhmonitordir:latest .
```

## Usage
Run the script without any arguments to see the Usage info, including examples.

To run via Docker, run the following command:
```
docker run --rm -v /opt/dockershare:/opt/dockershare bhmonitordir:latest "/opt/dockershare/out-vulnreview-summary-*"
```
