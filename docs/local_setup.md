# Local setup

[Back to README](../README.md)

## Prerequisites
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. Clone the project `git clone https://github.com/YasirAsar/coin_master.git`.
2. Navigate to the folder `cd coin_master`.
3. Copy env file `cp .env .env.dev`. Update the `.env.dev` with the know values(HOST, PORT..). Will update facebook tokens on this [configuration](/docs/facebook_messenger_configuration.md).
4. Build the service `docker-compose build`.
5. Start the server `docker-compose up`.
6. Open the docker interactive shell `docker exec -it coin_master_backend sh`.
7. After getting into the container. Get and compile the dependencies and project `mix do deps.get, compile`.
8. Start the interactive development server `iex -S mix phx.server`.
9. Now you can open the browser and visit [http://localhost:4000](http://localhost:4000).
