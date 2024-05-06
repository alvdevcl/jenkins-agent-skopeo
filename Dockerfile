FROM dwolla/jenkins-agent-core:4.13.2-1-jdk11-a73d9b7

USER root

RUN set -ex && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install git -y && \
    apt-get install -y \
        build-essential \
        libssl-dev \
        skopeo \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libffi-dev \
        liblzma-dev \
        default-libmysqlclient-dev

RUN chown -R jenkins ${JENKINS_HOME}

ENV PYENV_ROOT $JENKINS_HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN curl https://pyenv.run | bash && \
    eval "$(pyenv init --path)" && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> "${JENKINS_HOME}/.bashrc"

RUN chown -R jenkins:jenkins "${JENKINS_HOME}/.pyenv"

USER jenkins

RUN pyenv install 3.9

RUN pyenv global 3.9
