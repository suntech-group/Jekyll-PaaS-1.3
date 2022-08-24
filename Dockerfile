FROM ubuntu

RUN mkdir /jekyll
RUN mkdir /jekyll/Config
ADD Agent.sh /jekyll/Agent.sh
ADD Config/tunnel-ID /jekyll/Config/tunnel-ID
RUN chmod +x -R /jekyll/*
RUN apt update && apt install -y wget git

ENTRYPOINT ["sh", "-c", "/Agent.sh"]
