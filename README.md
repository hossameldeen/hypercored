**This repository has been archived. For any communication regarding it, including the possibility of unarchiving or making updates to it, feel free to open an issue on [archived-repos](https://github.com/hossameldeen/archived-repos).** This was made for the purpose of (1) adding Docker to [mafintosh/hypercored](https://github.com/mafintosh/hypercored), and (2) allowing the ability to use a different swarm port. I did use it (and am using it at the time of writing), but archiving because I don't know if I'll maintain it in the future. Anyway, if you want to make an enhancement or want to open a PR at mafintosh's repo with these changes, just ping me at the linked repo above.

# hypercored

A daemon that can download and share multiple hypercores and hyperdrives. Supports seeding them to the browser over WebSockets as well.
Backed by [hypercore-archiver](https://github.com/mafintosh/hypercore-archiver)

```
npm install -g hypercored
```

## Usage

``` js
# will watch ./feeds and store data in ./archiver
hypercored
```

For more info run

```
Usage: hypercored [key?] [options]

    --cwd         [folder to run in]
    --websockets  [share over websockets as well]
    --port        [explicit websocket port]
    --no-swarm    [disable swarming]
    --swarmport   [explicit swarm port]
```

## Docker

1. Install [Docker](http://docker.com/). If you're on Linux, remember to [configure Docker to start on boot](https://docs.docker.com/install/linux/linux-postinstall/). Don't know of the equivalent for other systems.

2. In the project root, run this command:

```
docker build -t hypercored:latest . && docker run -d --name=hypercored --restart=always -p 3282:3282 -v ~/.hypercored:/root/.hypercored hypercored:latest
```

3. Edit `~/.hypercored/feeds` on the host machine to edit feeds.  
Note: Seems like you'll need to do it in `sudo` because I've made some wrong decision somewhere.

**Notes:**  
1. Not an expert in Docker security or configuration.  
2. if you have Beaker on the same machine, you may want to change the dat port. To do that, (1) replace `3283` with your port in `Dockerfile`, and (2) Change `-p 3282:3282` in your command with `-p <yourPort>:<yourtPort>`.  
Just changing `-p 3282:3282` to, e.g., `-p 3283:3282` isn't working, probably because the datproject's signaling server is implemented in some way that requires `hypercored` to know of the real port (just a guess).  
3. To debug the running container:
   - Run `docker ps -a` to see the container running status.  
   - Run `docker logs hypercored` to see the logs.
   - Run `docker exec -it hypercored sh` to get into a terminal.

## License

MIT
