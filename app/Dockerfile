FROM nginx:1.27-alpine

RUN addgroup -S appgroup && adduser -S -u 1001 -G appgroup appuser

RUN sed -i 's/listen\s*80;/listen 8080;/' /etc/nginx/conf.d/default.conf \
 && sed -i '/^user\s/d' /etc/nginx/nginx.conf \
 && sed -i 's|^pid .*;|pid /tmp/nginx.pid;|' /etc/nginx/nginx.conf \
 && rm -rf /usr/share/nginx/html/* \
 && mkdir -p /var/cache/nginx/client_temp \
 && chown -R appuser:appgroup /var/cache/nginx /usr/share/nginx/html

COPY --chown=appuser:appgroup . /usr/share/nginx/html

USER 1001
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
