FROM ruby:2.7

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN apt-get update && apt-get install -y \
      curl \
      vim \
      default-jre \
      && \
  rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    # install the AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -q awscliv2.zip && \
    ./aws/install

RUN gem install bundler:2.2.21 && \
    bundle config set silence_root_warning 'true'

COPY deploy/Gemfile* /tmp/

RUN cd /tmp && \
    bundle install && \
    gem install s3_website && \
    rm -rf /root/.bundle/cache/*

# Install a quick colorized prompt and turn on ls coloring
RUN git clone https://github.com/nojhan/liquidprompt.git ~/liquidprompt && \
    echo '[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt' >>~/.bashrc && \
    mkdir -p ~/.config && \
    echo 'export LP_HOSTNAME_ALWAYS=1' >>~/.config/liquidpromptrc && \
    echo 'export LP_USER_ALWAYS=-1' >>~/.config/liquidpromptrc && \
    echo 'export LP_ENABLE_RUBY_VENV=0' >>~/.config/liquidpromptrc

RUN echo 'if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi' >>~/.bashrc && \
    echo 'export PATH="/code/bin:$PATH"' >>~/.bashrc
