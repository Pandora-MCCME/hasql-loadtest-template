echo installing for user $USER

sudo apt-get update

# Install general and dev packages
sudo apt-get install -y \
tmux htop vim \
strace valgrind gdb \
tmuxinator \
tcpdump

# Postgres
sudo apt-get install -y postgresql postgresql-client
sudo systemctl enable postgresql 
sudo systemctl restart postgresql
sudo -u postgres psql -c "CREATE USER $USER WITH PASSWORD '$USER'"
sudo -u postgres createdb -O $USER $USER
psql < initdb.sql
# test: psql -c "select * from objects"

# PgBouncer
sudo apt-get install -y pgbouncer
envsubst < pgbouncer/pgbouncer.ini | sudo tee /etc/pgbouncer/pgbouncer.ini | head 
envsubst < pgbouncer/userlist.txt | sudo tee /etc/pgbouncer/userlist.txt | head
sudo systemctl enable pgbouncer
sudo systemctl restart pgbouncer
# test: psql -p 6432 -c "select * from objects"

# Configure git
git config --global user.email "tester@testing"
git config --global user.name "Tester"
git config pull.ff only
