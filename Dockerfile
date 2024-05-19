FROM alpine

COPY inittab /etc/inittab
COPY rc.conf /etc/rc.conf

RUN apk add --update --no-cache openssh python3 py3-psutil openrc

COPY sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -A

# Install local ssh keys
RUN mkdir /root/.ssh
COPY ca-cert/* /root/.ssh/

RUN chmod 600 /root/.ssh/*
RUN ssh-keygen -I "host key" -s /root/.ssh/ca -h /etc/ssh/ssh_host_rsa_key.pub
RUN echo "cert-authority $(cat /root/.ssh/ca.pub)" >> /root/.ssh/authorized_keys && rm /root/.ssh/ca /root/.ssh/ca.pub
RUN rc-update add sshd

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 22
ENTRYPOINT /sbin/init
