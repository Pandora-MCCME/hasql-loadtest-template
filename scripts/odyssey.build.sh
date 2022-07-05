mkdir -p ~/builds
cd ~/builds

sudo apt-get update && \
sudo apt install \
cmake \
gcc \
openssl \
postgresql-server-dev

# pg_config utility is in the PATH

git clone git://github.com/yandex/odyssey.git
cd odyssey
make local_build
