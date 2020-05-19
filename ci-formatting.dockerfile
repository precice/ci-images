FROM alpine:3.10

# Install git, clang 8 (including clang-format) and GNU parallel
# Mute the request for citation. (We will cite)
RUN apk update && \
    apk upgrade && \
    apk add git bash clang parallel && \
    mkdir -p $HOME/.parallel && \
    touch $HOME/.parallel/will-cite
