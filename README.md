# gretel-upload-box

A vagrant box for gretel-upload

### Usage
Run `vagrant up`

To finish the installation and make gretel work do the following:
* go to `localhost:8080/gretel-upload` in your browser
* Upload a corpus with a quest account. (For example sarah_test.cha.zip)
* Reload the vagrant
* ssh to the virtual machine and start the basexserver (basexserver -S) 
* go to `localhost:8080/gretel` Gretel works now


The gretel upload site should be shown if everything went as intended


### Explanation

Vagrant is used to create a virtual machine in a repeatable manner.
This Vagrant file does the following interesting things:
       
1) It creates a ubuntu/xenial64 box
1) It links the localhost:8080 to port 80 on the quest machine
1) It runs a bunch of scripts that install packages and copies config files
    
    1) In particular install_lamp.sh is interesting because it makes use of a preseed. (/vagrant/vagrant_data/scripts/install_lamp.sh)
    

See VagrantFile for a more detailed explanation.

See vagrant_data/scripts for the scripts that are used

See vagrant_data/config for the config files that are used

