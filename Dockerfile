FROM nginx:latest
COPY *.jar /usr/share/nginx
EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
