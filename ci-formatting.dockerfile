FROM alpine:3.15

# Install git, clang (including clang-format) and GNU parallel
# Mute the request for citation. (We will cite)
RUN apk update && \
    apk upgrade && \
    apk add git bash clang parallel python3 py3-lxml py3-pip && \
    pip3 install cmake-format && \
    mkdir -p /root/.parallel && \
    touch /root/.parallel/will-cite && \
    ln -s /usr/bin/python3 /usr/local/bin/python
