FROM kubbee/minimal-fedora-golang:1.18

ARG aws_access_key_id
ARG aws_secret_access_key

ENV aws_access_key_id=${aws_access_key_id}
ENV aws_secret_access_key=${aws_secret_access_key}

WORKDIR /

COPY .aws .aws 

RUN sed -i -e 's/awsaccesskeyid/'${aws_access_key_id}'/g' .aws/credentials && \
    sed -i -e 's/awssecretaccesskey/'${aws_secret_access_key}'/g' .aws/credentials

WORKDIR /usr/local/

RUN microdnf -y install python3 && \
    microdnf -y install unzip && \
    microdnf -y install groff && \
    microdnf clean all

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

RUN ls
