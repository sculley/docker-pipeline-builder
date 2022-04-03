FROM alpine:latest

ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

ARG TF_VER="1.1.7"

# Install cdrkit for terraform cloud-init & useful packages
RUN apk add --no-cache cdrkit curl git wget ansible ansible-lint python3 openssh

WORKDIR /tmp

# Create a file with the arch so we can download TF for the right system
RUN echo "${TARGETPLATFORM}" | sed 's/linux\///g' > /tmp/arch

RUN ARCH=`cat /tmp/arch` && \
    curl -sLo terraform.zip "https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_${ARCH}.zip" && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv ./terraform /usr/local/bin/terraform

WORKDIR /

ENTRYPOINT []