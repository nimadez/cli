#!/bin/bash
#
# Generate debian sources.list

# You need all these keys for the drivers to work properly
KEYS="contrib non-free non-free-firmware"

read -p "Start mirror benchmark (y)? " bench
if [ "$bench" = "y" ]; then
    sudo apt -y install netselect-apt
    sudo netselect-apt
fi

read -p "Mirror URL (enter=http://deb.debian.org/debian/): " mirror
if [ "$mirror" = "" ]; then
    mirror="http://deb.debian.org/debian/"
fi

# create backup
sudo cp -rf /etc/apt/sources.list /etc/apt/sources.list.bkp
echo Backup created: /etc/apt/sources.list.bkp
read -p "press enter to continue ..." p

echo 1. stable \(bookworm - main only\)
echo 2. stable \(bookworm - $KEYS\)
echo 3. stable-proposed \(bookworm - $KEYS\)
echo 4. stable-proposed-backports \(bookworm - $KEYS\)
echo 5. testing \(trixie - lazy security - $KEYS\)
echo 6. unstable \(sid - no security - $KEYS\)
read -p "Branch: " branch
echo

if [ "$branch" -eq 1 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror stable main
deb-src $mirror stable main
deb $mirror stable-updates main
deb-src $mirror stable-updates main
deb http://security.debian.org/debian-security/ stable-security main 
deb-src http://security.debian.org/debian-security/ stable-security main
EOF
echo;echo saved to /etc/apt/sources.list
elif [ "$branch" -eq 2 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror stable main $KEYS
deb-src $mirror stable main $KEYS
deb $mirror stable-updates main $KEYS
deb-src $mirror stable-updates main $KEYS
deb http://security.debian.org/debian-security/ stable-security main $KEYS
deb-src http://security.debian.org/debian-security/ stable-security main $KEYS
EOF
echo;echo saved to /etc/apt/sources.list
elif [ "$branch" -eq 3 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror stable main $KEYS
deb-src $mirror stable main $KEYS
deb $mirror stable-updates main $KEYS
deb-src $mirror stable-updates main $KEYS
deb $mirror bookworm-proposed-updates main $KEYS
deb-src $mirror bookworm-proposed-updates main $KEYS
deb http://security.debian.org/debian-security/ stable-security main $KEYS
deb-src http://security.debian.org/debian-security/ stable-security main $KEYS
EOF
echo;echo saved to /etc/apt/sources.list
elif [ "$branch" -eq 4 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror stable main $KEYS
deb-src $mirror stable main $KEYS
deb $mirror stable-updates main $KEYS
deb-src $mirror stable-updates main $KEYS
deb $mirror bookworm-proposed-updates main $KEYS
deb-src $mirror bookworm-proposed-updates main $KEYS
deb $mirror bookworm-backports main $KEYS
deb-src $mirror bookworm-backports main $KEYS
deb http://security.debian.org/debian-security/ stable-security main $KEYS
deb-src http://security.debian.org/debian-security/ stable-security main $KEYS
EOF
echo;echo saved to /etc/apt/sources.list
elif [ "$branch" -eq 5 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror testing main $KEYS
deb-src $mirror testing main $KEYS
deb $mirror testing-updates main $KEYS
deb-src $mirror testing-updates main $KEYS
deb http://security.debian.org/debian-security/ testing-security main $KEYS
deb-src http://security.debian.org/debian-security/ testing-security main $KEYS
EOF
echo;echo saved to /etc/apt/sources.list
elif [ "$branch" -eq 6 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror unstable main $KEYS
deb-src $mirror unstable main $KEYS
EOF
echo;echo saved to /etc/apt/sources.list
fi

read -p "run 'sudo apt update' (y)? " up
if [ "$up" = "y" ]; then
    sudo apt update
fi
