#!/bin/bash -e
#
clear
echo " "
echo  "\x1B[36mMMMMMMMMMMMMMMMMWKMMMMM.   ..;oONMMMMMMMMMMMMMMMM\x1B[0m" && echo  "\x1B[36mMMMMMMMMMMMNkc,. OMMMMc          .,ckNMMMMMMMMMMM\x1B[0m" && echo  "\x1B[36mMMMMMMMM0c.     kMMMMc                .c0MMMMMMMM\x1B[0m" && echo  "\x1B[36mMMMMMNl.       dMMMMo                    .lNMMMMM\x1B[0m" && echo  "\x1B[36mMMMWc         oMMMMx                        cWMMM\x1B[0m" && echo  "\x1B[36mMMO.         lMMMM0.....       ...........   .OMM\x1B[0m" && echo  "\x1B[36mMk          cMMMMMMMMMMMWk    'WMMMMMMMMMMM0.  kM\x1B[0m" && echo  "\x1B[36m0          :MMMMO.  :MMMMK   .WMMMX.  'NMMMN.   0\x1B[0m" && echo  "\x1B[36m'         ,WMMM0   .WMMMX   .NMMMN.  .XMMMW.    '\x1B[0m" && echo  "\x1B[36m         'WMMMK   .NMMMN.  .XMMMW.   KMMMW,\x1B[0m" && echo  "\x1B[36m        'WMMMX.  .NMMMN.  .XMMMW'   0MMMW;\x1B[0m" && echo  "\x1B[36m'      .WMMMX.  .NMMMN.   KMMMW,   0MMMM;       '\x1B[0m" && echo  "\x1B[36m      .NMMMN.  .XMMMW.   KMMMMc...OMMMM:        K\x1B[0m" && echo  "\x1B[36m     .XMMMW.   KMMMW,   OMMMMMMMMMMMMX:        kM\x1B[0m" && echo  "\x1B[36mMM0.  ....     .....   kMMMMc.......         .0MM\x1B[0m" && echo  "\x1B[36mBMMMWl                 xMMMMl               lWMMM\x1B[0m" && echo  "\x1B[36mMMMMMNo.             xMMMMo              .oNMMMMM\x1B[0m" && echo  "\x1B[36mMMMMMMMM0l.         oMMMMd            .l0MMMMMMMM\x1B[0m" && echo  "\x1B[36mMMMMMMMMMMMNkl,.   cMMMMk        .,lkNMMMMMMMMMMM\x1B[0m" && echo  "\x1B[36mMMMMMMMMMMMMMMMMW0dMMMMW   ..;o0WMMMMMMMMMMMMMMMM\x1B[0m" && echo  "    Hewlett-Packard Company, Established 1939" && echo  "**************************************************" && echo  "http://www8.hp.com/us/en/privacy/terms-of-use.html" && echo  "**************************************************"
echo " "
echo "This Script Will Deploy OctoPress on OpenStack Swift Object Storage."
read -p "Hit Y or N " -n 1 -r
echo " "
echo "+++++"
echo "You Should Place This Script at Your $HOME Directory and Execute it."
echo "This Script is Dependent on Python Swift Client."
echo "This Script is intended to run on Linux, OS X, HP-UX and Other unix or unix like OS."
echo "This Script needs Python Swift Client to be configured rightly."
echo "++++++"
echo " "
echo "Is everything is fine?"
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Run this script in a separate new Terminal Window with Sudo Privilege"
echo "You can get sudo privilege by running :"
echo "sudo su"
fi
echo " "
echo "Run this command in a separate new Terminal Window with Sudo Privilege"
echo " "
echo "You need to have Python Swift Client installed and configured on your local computer. Read the following guide."
echo "\x1B[36m https://thecustomizewindows.com/2015/01/python-script-upload-files-openstack-swift-hp-cloud-cdn/\x1B[0m"
echo "DO NOT USE THIS SCRIPT ON ALREADY RUNNING OCTOPRESS"
echo " "
echo "+++++"
echo "+"
echo "+  You must have installed git, ruby and ruby-dev beforehand."
echo "+"
echo "+  If you are not ready, close this window"
echo "+  and again run this script after the needed things installed."
echo "+  Do not run from iTerm2 in case of OS X, use Terminal"
echo "+ "
echo "+  We Will Not Check for Errors. Script Will Run of its Own."
echo "+  THIS SCRIPT HAS NO TIMEOUT. BE LAZY."
echo "+  DR. ABHISHEK GHOSH CREATED THIS THING and Released Under GNU GPL 3.0"
echo "+"
echo "++++++"
echo " "
read -p "Read the instruction? Y will proceed, N will Quit " -n 1 -r

RUBY_VERSION=1.9.3-p448

#sudo brew update #1
#sudo brew install git ruby ruby-dev #2
#sudo rm -rf octopress #3
echo "We will cd to $HOME"
echo " "
cd ~
echo "Your OctoPress on local computer is at"
pwd
echo " "
echo "We will delete any existing directory with the name octopress."
rm -r -f octopress
echo " "
echo " "
echo "Supply the container name below:"
read container
echo " "
echo "Now, visit :"
echo "https://horizon.hpcloud.com/project/containers/"
echo "and make the container named $container public & enable CDN."
echo " "
echo "You should create a custom _config.yml file. We will delete the default one "
echo "and ask you a custom _config.yml file's URL, you can use Github Gist's RAW URL."
echo "A basic example is like :"
echo "https://gist.githubusercontent.com/AbhishekGhosh/d8283097c50c2b5d64a1/raw/3b6b914d88b5c7f49dded82ff71d1c696fc7bcfb/_config.yml"
echo " "
echo "copy that url and paste when we will ask you."
echo "Ruby will take some time and it might appear nothing working."
echo "Wait before you exit or face error."
git clone git://github.com/imathis/octopress.git octopress && cd octopress
sudo gem install bundler
rbenv rehash
bundle install
rake install
cd ..
mkdir _deployment && cd _deployment
cp ../octopress/config.ru .
cp ../octopress/Gemfile .
bundle install
mkdir public/
git init .
# git remote add openshift $key
git add .
git commit -am 'initial deploy'
cd ..
mv _deployment octopress
cd octopress
rm -r _config.yml
echo "Supply the full URL of the _config.yml file:"
read yml
echo " "
wget $yml
echo " "
git add _deployment/
rake install
echo "Depending on your environment, use bundle exec"
echo "Edit and save the file in source/_posts/2015-02-09-Hello-World.markdown"
echo "Proceed? Y/N"
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
rake new_post['Hello World'] 
echo "sudo su"
fi
rake generate
rm -rf _deployment/public/*
cp -R public/* _deployment/public/
swift upload $container *
finish=`date "+%Y-%m-%d-%H-%M-%S"`
echo "Deployment at Swift container $container completed at ${finish}"
echo "That is it."
echo "https://thecustomizewindows.com"
echo "Can not Remember? OK, this one:"
echo "JiMA.in"
echo " "
echo "Check whether OctoPress is actually running..."
echo " "
echo "DO NOT USE THIS SCRIPT ON ALREADY RUNNING OCTOPRESS."
echo "USE OCTOPRESS DOCUMENTATION."
read -p "OK. This Script Will Quit. That is Desired. Hit Y or N " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
exit
fi
