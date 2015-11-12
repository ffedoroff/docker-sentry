FROM sentry:7.7.0

# temporary swithc to root user
USER root

# you can add any plugins to sentry here
# RUN pip install https://github.com/getsentry/sentry-slack/archive/master.zip
# RUN pip install https://github.com/getsentry/sentry-auth-google/archive/master.zip

# add custom config file support
COPY custom.conf.py /home/user/
RUN  echo "execfile('/home/user/custom.conf.py')" >> /home/user/docker-links.conf.py

# switch back to default user
USER user
