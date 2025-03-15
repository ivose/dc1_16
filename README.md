# Simple Python CI/CD

This repository contains a simple Python/Flask app along with a CI/CD pipeline that automatically builds and pushes a Docker image to Docker Hub on every push to the **main** branch.

The deployed application is available at: [https://dc1-16.onrender.com](https://dc1-16.onrender.com)

## How It Works

- **GitHub Actions Workflow:**  
  Every push to the **main** branch triggers a workflow that:
  1. Checks out the code.
  2. Sets up Docker Buildx.
  3. Logs in to Docker Hub (using secrets).
  4. Builds the Docker image and pushes it to Docker Hub with the tag `latest`.

- **Deployment:**  
  On your target server (or cloud host) you can run a container using the image from Docker Hub. For automated updates, you can run Watchtower which will pull and restart the container when a new image is available.

## Running Locally

To run the app locally:

```bash
docker build -t dc1_16 .
docker run -p 5000:5000 dc1_16
```

### Deployment Pipeline Overview

1. **CI/CD via GitHub Actions:**  
   The workflow in `.github/workflows/deploy.yml` ensures that every push to **main** automatically builds and pushes a Docker image to Docker Hub.

2. **Automated Deployment:**  
   You can use a tool like [Watchtower](https://containrrr.dev/watchtower/) on your cloud host to monitor your running container and automatically update it when a new image is pushed.

For example, your deployment using Docker Compose with Watchtower might look like this:

```yaml

services:
  app:
    image: ivo123/dc1_16:latest
    ports:
      - "5000:5000"

  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    environment:
      - WATCHTOWER_POLL_INTERVAL=60
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
