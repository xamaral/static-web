FROM nginx:1.17.0

COPY nginx.conf /etc/nginx/nginx.conf

COPY output /usr/share/nginx/html

