sudo apt-get update &&
sudo apt-get install -y \
tmux htop vim \
strace valgrind gdb \
tmuxinator \
tcpdump \
postgresql postgresql-client pgbouncer \
# etc

sudo -u postgres createuser --no-password debian
sudo -u postgres createdb -O debian debian

git config --global user.email "tester@testing"
git config --global user.name "Tester"
