FROM nginx:latest
COPY spring-boot-mongo-1.0.jar /usr/share/nginx
EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
