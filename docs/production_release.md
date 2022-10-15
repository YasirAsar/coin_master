# Production Release

[Back to README](../README.md)

Create a docker image with release artifact.

1. Navigate to the project directory and run `docker image build -t elixir/coin_master .`
2. Once the image is build. Push the image to the docker Hub.
3. Switch to the target/production server.
4. Production server should want to have docker [install the docker](https://docs.docker.com/engine/install/).
5. Pull the image from the docker Hub.
6. Copy the `.env` file from the github to the production server and update the environments.
7. Start the application by running `docker container run -dp $PORT:$PORT --env-file ".env"  --name coin_master elixir/coin_master`
8. Navigate to the configured URL to confirm.