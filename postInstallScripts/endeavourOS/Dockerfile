FROM alpine:latest 

RUN apk --no-cache --update add \
  bash \
  g++\
  curl \
  git \
  make \
  python3 \
  py3-pip\
  npm \
  nodejs \
  cargo \
  neovim 

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH

RUN curl https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -o lvim.sh && \
  chmod +x lvim.sh && \
  bash lvim.sh --install-dependencies ; exit 0 
# exit 0 because verify install always breaks

RUN ~/.local/bin/lvim --headless +PackerSync +qa && \
  rm lvim.sh

RUN touch ~/.bashrc && \
  echo alias lvim="~/.local/bin/lvim" > ~/.bashrc && \
  source ~/.bashrc

CMD ["source","~/.bashrc"]
