ssh-keygen -f ca
echo "@cert-authority * $(cat ca.pub)" >> ~/.ssh/known_hosts
ssh-keygen -f ~/.ssh/customalpinedocker
ssh-keygen -s ca -I 'Client' ~/.ssh/customalpinedocker.pub
