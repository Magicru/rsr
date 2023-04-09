FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package*.json /app/package.json

RUN npm install --silent

COPY . /app

RUN npm run build

FROM nginx:1.16.0-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]