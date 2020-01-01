FROM node:alpine as buildphase
WORKDIR '/app'
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build
#NB: No need to add a container default command bcos this is not our run phase

FROM nginx
COPY --from=buildphase /app/build /usr/share/nginx/html
# NB: default command of nginx base image will start the server
