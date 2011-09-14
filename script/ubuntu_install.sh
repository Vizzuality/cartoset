#!/bin/sh
# this script install cartoset on ubuntu distribution

# update package
    sudo apt-get update
    sudo apt-get  install -y curl

# dowload cartoset
    echo "downloading cartoset"
    curl -L https://github.com/Vizzuality/cartoset/tarball/master -o cartoset.tar.gz
    tar -xzf cartoset.tar.gz
    mv Vizzuality-cartoset* cartoset


# install ruby stuff, ruby and rubygems

    sudo apt-get install -y ruby1.9.1-full rubygems1.9.1
    curl -L http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz -o rubygems.tar.gz
    tar -xzf rubygems.tar.gz && cd rubygems-1.8.10 && sudo ruby setup.rb && cd ..
    sudo gem1.8 install bundler

# git

    sudo apt-get install -y git-core

# development libraries

    sudo apt-get install -y libxml2-dev libxslt-dev libcurl4-gnutls-dev

# postgre

    sudo apt-get install -y python-software-properties checkinstall
    sudo add-apt-repository ppa:pitti/postgresql
    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
    sudo apt-get update
    sudo apt-get install -y postgresql-9.0 postgresql-server-dev-9.0

# bundle install

    cd cartoset
    bundle install

echo "*******************************"
echo "installed succesfully /o/. Now you may want to run\n  $ cd cartoset && rails server"
echo "*******************************"
