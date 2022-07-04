FROM alpine:latest as builder

# LABEL maintainer "Henri Vandersleyen <henri-vandersleyen@protonmail.com>"

RUN apk --no-cache --update add \
  bash \
  curl \
  git \
  make \
  python3 \
  py3-pip\
  npm \
  nodejs \
  cargo \
  neovim 

RUN bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) \
  bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)

WORKDIR /src

ENTRYPOINT ["nvim"]
CMD ["/src"]
