# Credits: https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
FROM node:8.12.0-jessie

RUN apt-get update && apt-get install -y libtool m4 automake libcap2-bin build-essential

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If you are building your code for production
RUN npm install --only=production
RUN npm install pm2 -g

COPY . .

# From Node's Best Practices
# See: https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#environment-variables
# Note: Only this is applied from the practices.
ENV NODE_ENV production
ENV SWARM_PORT 3282

# Note: you still need to supply -p 3282:3282
EXPOSE 3282

CMD pm2-runtime start index.js -- --cwd /root/.hypercored --swarmport $SWARM_PORT
