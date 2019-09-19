# STEP-01
FROM nginx:alpine

# STEP-02
RUN rm /usr/share/nginx/html/index.html
RUN /usr/share/nginx/html/index2.html

# STEP-03: COPY SOURCE CODE TO PRODUCTION
COPY index.html /usr/share/nginx/html/index.html
COPY index2.html /usr/share/nginx/html/index2.html
