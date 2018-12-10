# hypercored-docker

Using Docker with [mafintosh/hypercored](https://github.com/mafintosh/hypercored). Needed to fork to add `--swarmport`. Unfortunately, that means I'm tied to a specific `hypercored` version and will need to sync manually. Note: I most probably won't, this is just for now.

## Usage

1. Install [Docker](http://docker.com/). If you're on Linux, remember to [configure Docker to start on boot](https://docs.docker.com/install/linux/linux-postinstall/). Don't know of the equivalent for other systems.

2. In the project root, run this command:

```
docker build -t hypercored:latest . && docker run -d --name=hypercored --restart=always -p 3282:3282 -v ~/.hypercored:/root/.hypercored hypercored:latest
```

3. Edit `~/.hypercored/feeds` on the host machine to edit feeds.  
Note: Seems like you'll need to do it in `sudo` because I've made some wrong decision somewhere.

**Notes:**  
1. Not an expert in Docker security or configuration.  
2. If `3282` port is already taken (e.g., because you have Beaker running on the same machine), you can change the dat port:
   1. change `-p 3282:3282` in your command with `-p <yourPort>:<yourtPort>`.
   2. add `-e SWARM_PORT <yourPort>` anywhere before `hypercored:latest` and after `build`. Just changing `-p 3282:3282` to, e.g., `-p 3283:3282` isn't working, probably because the datproject's signaling server is implemented in some way that requires `hypercored` to know of the real port (just a guess).  
3. To debug the running container:
   - Run `docker ps -a` to see the container running status.  
   - Run `docker logs hypercored` to see the logs.
   - Run `docker exec -it hypercored sh` to get into a terminal.

## License

MIT
