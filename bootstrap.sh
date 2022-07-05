echo installing for user $USER

sudo apt-get update

# Instal general and dev packages
sudo apt-get install -y \
tmux htop vim \
strace valgrind gdb \
tmuxinator \
tcpdump

# Postgres
sudo apt-get install -y postgresql postgresql-client pgbouncer
sudo service postgresql start
sudo -u postgres createuser --no-password $USER
sudo -u postgres createdb -O $USER $USER
psql < initdb.sql

# Configure git
git config --global user.email "tester@testing"
git config --global user.name "Tester"
git config pull.ff only
