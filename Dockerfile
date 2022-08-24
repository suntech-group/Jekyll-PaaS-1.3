FROM ubuntu

RUN mkdir /jekyll
ADD Agent.sh /jekyll/Agent.sh
RUN chmod +x /jekyll/Agent.sh
RUN apt update && apt install -y wget git

ENTRYPOINT ["sh", "-c", "/jekyll/Agent.sh"]
