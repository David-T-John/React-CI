FROM node:alpine as build-deps
WORKDIR /client/app
COPY package*.json /client/app
RUN npm install --verbose
COPY . /client/app
RUN npm run build --verbose


FROM nginx:1.17.1-alpine
EXPOSE 80

COPY --from=build-deps /client/app/build /usr/share/nginx/html
CMD ["nginx", "-g"]