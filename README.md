# gito

Editor agnostic realtime pair programing (PoC)

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

Create a central gito repo

```sh
sudo -u gito gito init ~gito/central
```

Connect localy

```sh
gito clone ~gito/central my-share
```

Connect remotely. Don't forget to start your sshd.

```sh
gito clone gito@127.0.0.1:central my-remote-share
```

After you have cloned a gito repo you can start syncing files.

To listen and push realtime updates use ```gito listen``` and keep it running.

Then you can start editing files.

```sh
cd my-share
echo Look at this file! > a-file
gito sync
```
