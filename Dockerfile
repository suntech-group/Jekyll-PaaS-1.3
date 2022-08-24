FROM ubuntu

RUN mkdir /jekyll
ADD Agent.sh /jekyll/Agent.sh
RUN chmod +x /jekyll/Agent.sh

ENTRYPOINT ["sh", "-c", "/Agent.sh"]
