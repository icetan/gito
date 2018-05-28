# gito

Editor agnostic realtime pair programing with git as backend (PoC)

## Setup

Copy source and add to ```PATH```.

```sh
git clone https://github.com/icetan/gito
export PATH=$PWD/gito:$PATH
```

## Usage

Start a central gito share by first creating a shared ssh user.

```sh
sudo useradd -m gito
sudo -u gito mkdir -p ~gito/.ssh
sudo -u gito tee -a ~gito/.ssh/authorized_keys < ~/.ssh/id_rsa.pub
sudo chmod g+s ~gito
sudo chmod -R 755 ~gito
sudo chmod 600 ~gito/.ssh/authorized_keys
```

Create a directory with files that you want to share.

```sh
mkdir my-share
cd my-share
echo Look at this file! > a-file
```

Start sharing your files.

```sh
gito connect gito@127.0.0.1:shared-repo
```

Then you can start editing files.

```sh
echo It is awesome >> a-file
gito sync
```

Each time you do ```gito sync``` your changes will be pushed out to the
connected repo.

Check out the ```editor-plugins``` directory for the best experience with your
editor.
