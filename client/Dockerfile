#--------------------------#
# meishi-ui用のDockerfile
#--------------------------#
FROM nginx:latest

VOLUME ["/etc/nginx", "var/log/nginx"]

EXPOSE 80 443

RUN rm -rf /etc/nginx/nginx.conf

COPY meishi_ui /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
