FROM alpine
RUN apk --update add --no-cache openssh bash python3 py3-psutil openrc busybox-openrc

RUN ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config

# Install local ssh keys
RUN mkdir /root/.ssh
COPY ca-cert/* /root/.ssh/
RUN ssh-keygen -I "host key" -s /root/.ssh/ca -h /etc/ssh/ssh_host_rsa_key.pub
RUN echo "cert-authority $(cat /root/.ssh/ca.pub)" >> /root/.ssh/authorized_keys && rm /root/.ssh/ca /root/.ssh/ca.pub

EXPOSE 22
ENTRYPOINT openrc; touch /run/openrc/softlevel; rc-service syslog start; rc-service sshd start; tail -f /var/log/messages
