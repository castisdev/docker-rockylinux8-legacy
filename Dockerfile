# Pull base image
FROM rockylinux/rockylinux:8

LABEL org.opencontainers.image.source https://github.com/castisdev/docker-rockylinux8-legacy

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install EPEL repo
RUN yum install -y epel-release; yum -y clean all

# Install
RUN yum install -y \
  sudo \
  wget \
  gcc \
  gcc-c++ \
  make \
  unzip \
  openssl \
  openssl-devel \
  git \
  subversion \
  tar \
  boost-devel \
  glibc-devel \
  libuuid-devel \
  gdb \
  valgrind \
  mariadb-devel \
  postgresql-server-devel \
  curl-devel \
  xz \
  file \
  vim-enhanced \
  unixODBC-devel \
  mariadb-connector-odbc \
  sysstat \
  psmisc \
  yum-utils \
  tbb-devel \
  gperftools-devel \
  iproute \
  net-tools \
  ccache \
  libunwind-devel \
  libwebp-devel \
  protobuf-compiler \
  libasan \
  patch \
  && yum -y clean all

RUN yum -y --enablerepo=powertools install boost-static; yum -y clean all

ADD install_xercesc280.sh /script/
RUN /script/install_xercesc280.sh

ADD install_cmake402.sh /script/
RUN /script/install_cmake402.sh

ADD install_boost188.sh /script/
RUN /script/install_boost188.sh
ENV Boost_DIR /root/boost_1_88_0

ADD install_cryptopp890.sh /script/
RUN /script/install_cryptopp890.sh

ADD install_googletest1170.sh /script/
RUN /script/install_googletest1170.sh

ADD install_python.sh /script/
RUN /script/install_python.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

ADD install_cppcheck2170.sh /script/
RUN /script/install_cppcheck2170.sh

ADD install_zsh59.sh /script/
RUN /script/install_zsh59.sh

ADD install_ninja1121.sh /script/
RUN /script/install_ninja1121.sh

ADD install_golang1243.sh /script/
RUN /script/install_golang1243.sh

ADD install_wrk420.sh /script/
RUN /script/install_wrk420.sh

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Add root files
ADD .bashrc /root/.bashrc

# Set environment variables
ENV HOME /root
ENV PATH="${PATH}:${HOME}/go/bin:/usr/local/go/bin"

# Define default command
CMD ["zsh"]
