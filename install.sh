#!/bin/bash

MB_USER="magicbox"

MB_DIR_PATH="/opt/magicbox"
MB_REPO_URL="https://github.com/nark/magicbox.git"

RAILS_ENV=production

print_header () {
  printf "#########################################\n"
  printf "# START $1 \n"
  printf "\n"
}

print_footer () {
  printf "\n# END $1\n"
  printf "#########################################\n\n"
}

source .env

# install dependencies with apt
print_header "install dependencies with apt" 
sudo apt-get update -q
sudo apt-get install -qy procps curl ca-certificates gnupg2 build-essential postgresql postgresql-contrib libpq-dev git nodejs apt-utils libmagickcore-dev libmagickwand-dev  --no-install-recommends
print_footer "install dependencies with apt" 

# install yarn
print_header "install yarn" 
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn
print_footer "install yarn" 

# create system user
print_header "create system user"
sudo adduser --disabled-password --gecos "" $MB_USER
print_footer "create system user" 

# install RVM
print_header "install RVM"
sudo gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
sudo curl -sSL https://get.rvm.io | sudo bash -s stable
sudo -u $MB_USER -H bash -c "echo 'source /usr/local/rvm/scripts/rvm' >> /home/$MB_USER/.profile"
sudo usermod -a -G rvm $MB_USER
sudo usermod -a -G rvm $USER
print_footer "install RVM" 

# install Ruby
print_header "install Ruby"
source /usr/local/rvm/scripts/rvm
rvmsudo source /usr/local/rvm/scripts/rvm
rvmsudo rvm install ruby-2.7.2
rvmsudo rvm use ruby-2.7.2 --default
print_footer "install Ruby" 

# install bundler
print_header "install bundler"
sudo -u $MB_USER -H bash -c 'source /usr/local/rvm/scripts/rvm && gem install bundler -v 2.1.4'
print_footer "install bundler"

# setup postgresql
print_header "setup postgresql"
sudo -u postgres psql -c "CREATE ROLE $DATABASE_USER WITH LOGIN PASSWORD '$DATABASE_PASSWORD';"
sudo -u postgres psql -c "ALTER ROLE $DATABASE_USER SUPERUSER CREATEROLE CREATEDB REPLICATION;"
print_footer "setup postgresql" 

# create MB dir
print_header "create MB dir"
mkdir -p $MB_DIR_PATH
chown -R $MB_USER:$MB_USER $MB_DIR_PATH
print_footer "create MB dir" 

# copy env file
print_header "copy env file"
cp .env $MB_DIR_PATH/.env
print_footer "copy env file"

# clone sources
print_header "clone sources"
git clone $MB_REPO_URL $MB_DIR_PATH
print_footer "clone sources"

# install gems
print_header "install gems"
sudo -u $MB_USER -H bash -c 'source /usr/local/rvm/scripts/rvm && bundle install --without development test'
print_footer "install gems"

# run yarn install to install JavaScript dependencies.
print_header "run yarn install"
yarn install --check-files
chown -R $MB_USER:$MB_USER $MB_DIR_PATH
print_footer "run yarn install"

# init database
print_header "setup database"
sudo -u $MB_USER -H bash -c 'source /usr/local/rvm/scripts/rvm && bundle exec rake db:create'
sudo -u $MB_USER -H bash -c 'source /usr/local/rvm/scripts/rvm && bundle exec rake db:migrate'
sudo -u $MB_USER -H bash -c 'source /usr/local/rvm/scripts/rvm && bundle exec rake db:seed'
print_footer "setup database"

