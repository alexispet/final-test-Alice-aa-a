FROM node:21.5.0-alpine3.19 AS build

COPY . /app/
WORKDIR /app

RUN npm ci
#RUN npm run start

FROM node:21.5.0-alpine3.19 AS express

LABEL org.opencontainers.image.source https://github.com/alexispet/final-test-Alice-aa-a

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json .
COPY --from=build /app/database ./database
COPY --from=build /app/app.js .

EXPOSE 4000

COPY docker/express/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

CMD ["npm", "run", "start"]