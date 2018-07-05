# GrETEL Vagrant Box

A vagrant box for GrETEL, including the Upload functionality.

## Usage

Run `vagrant up`

To finish the installation and make gretel work do the following:

* Go to `localhost:8080/gretel-upload` in your browser
* Upload a corpus with a guest account
* Go to `localhost:8080/gretel` Gretel works now

Both `gretel` and `gretel_upload` are cloned to `vagrant_data` and you can start working on it.

## Troubleshooting

Make sure that all users have full access (777) to the content of vagrant data. This is necessary because of a quirk with the shared directories.

## Explanation

Vagrant is used to create a virtual machine in a repeatable manner.
This Vagrant file does the following interesting things:

1) It creates a `ubuntu/bionic64` box.
1) It links the `localhost:8080` to port `80` on the guest machine.
1) It runs a bunch of scripts that install packages and copies config files.
    1) In particular `install_mysql.sh` is interesting because it makes use of a preseed: `/vagrant/vagrant_data/scripts/mysql-server.preseed`.

See `VagrantFile` for a more detailed explanation.

See `vagrant_data/scripts` for the scripts that are used.

See `vagrant_data/config` for the config files that are used.
