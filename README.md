<p align="center">
    <img src="https://user-images.githubusercontent.com/56378698/127357452-1b57af9c-be5a-42ff-aecb-bd2e2c006716.png" alt="Pioneer logo" width="200" height="200">
</p>

# Pioneer

Pioneer is an open-source feature management service consisting of several components.  The `docker-comopse.yml` provided in this repository can be run with the command `docker-compose up` in order to spin up all docker containers necessary.

For more information about Pioneer, check out our [case study](https://pioneer-io.github.io/).

## Usage

For out-of-the-box usage of Pioneer, execute the below commands.

```
$ git clone https://github.com/pioneer-io/pioneer.git
$ cd pioneer
$ docker-compose up
```

That's it!  You can visit port `:3000` to interact with the `compass` application user interface.  To bring down the containers, run `docker-compose down`.

For more information about the containers orchestrated by the `docker-compose.yml`, read on.

## Containers

### Compass
The Compass application provides the interface with which a user can create, update, and delete feature flags. The front-end is built with React.  The back-end is built with Express and handles streaming feature flag updates to the Scout daemon. The Compass UI is available at port `:3000` while the server runs on `:3001`. [Compass repository](https://github.com/pioneer-io/compass).

### Scout
The Scout daemon will run on port `:3030` by default. Scout receives feature flag updates from Compass via NATS and uses server-sent events to stream these updates to connected SDK clients. [Scout repository](https://github.com/pioneer-io/scout).

### NATS
The NATS container will run on port `:4222`. NATS is used to stream feature flag data between Compass and Scout. 

### PostgreSQL
The postgres container will run on the default port `:5432` unless changed.  The `.env` file provided with this repository contains default values for `POSTGRES_USER`, `POSTGRES_PORT`, and `POSTGRES_PASSWORD`. It is recommended that the user update these for production use.

## SDKs

Pioneer currently offers server-side SDKs for applications written in [Ruby](https://github.com/pioneer-io/ruby-sdk), [Go](https://github.com/pioneer-io/go_sdk), and [Node.js](https://github.com/pioneer-io/javascript-sdk). Visit the appropriate repository for instructions on getting started with one of the Pioneer SDKs.
