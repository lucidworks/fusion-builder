FROM sonarsource/sonar-scanner-cli:4.3

USER 0 

RUN apt-get update && apt-get install -y gcc &&  wget -q https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz && \
  echo "export PATH=\"\${PATH}:/usr/local/go/bin\"" >> /home/scanner-cli/.profile && \
  rm go1.14.2.linux-amd64.tar.gz

USER 1000 
