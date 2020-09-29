FROM alpine:3.10

# Install git, clang 8 (including clang-format) and GNU parallel
# Mute the request for citation. (We will cite)
RUN apk update && \
    apk upgrade && \
    apk add git bash clang parallel python3 py3-lxml && \
    mkdir -p /root/.parallel && \
    touch /root/.parallel/will-cite
