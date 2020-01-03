# sync

Sync is a tool to help you to keep your local dev environment settings backed up.




## Use Cases

1. storing your ssh keys somewhere

2. Your bash, zsh development machine settings

## Logic

You tell it the local folder (s) to keep in sync. For example your $HOME/.ssh

It will then keep them in sync via PR requests OR via a repo you have checked out for which it will then call the sync to the remote repo for you.



## Remote Storage Providers

It will then sync the files with a git repo somewhere.

New Providers can be added to sync the files with a S3 system instead if you prefer that.

## Crypto

For now we will use a generic crypto cipher.

Various crypto schemes will be provided later, such as PGP, etc
