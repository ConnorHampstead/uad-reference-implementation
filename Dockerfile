# Layer 1: Application Logic
FROM node@sha256:0340fa682d72068edf603c305bfbc10e23219fb0e40df58d9ea4d6f33a9798bf

RUN apk add --no-cache curl

WORKDIR /usr/src/app

COPY src/package*.json ./
RUN npm install --omit=dev

COPY src ./src

CMD [ "node", "src/index.js" ]