FROM ghcr.io/cirruslabs/flutter:3.32.8 AS build

WORKDIR /app


ARG API_URL
ARG BASE_URL

ENV API_URL=$API_URL
ENV BASE_URL=$BASE_URL


COPY pubspec.* ./
RUN flutter pub get

COPY . .

RUN flutter build web \
    --dart-define=BASE_URL=$BASE_URL\
    --dart-define=API_URL=$API_URL

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]