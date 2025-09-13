#!/bin/bash
#
# Generate standard debian sources.list

STABLE="trixie"
KEYS="contrib non-free non-free-firmware"

echo "Default Mirror:   http://deb.debian.org/debian/"
echo "Default Security: http://security.debian.org/debian-security/"
echo
read -p "Mirror (Empty=default): " mirror
read -p "Security (Empty=default): " mirror_sec

if [ "$mirror" = "" ]; then
    mirror="http://deb.debian.org/debian/"
fi
if [ "$mirror_sec" = "" ]; then
    mirror_sec="http://security.debian.org/debian-security/"
fi

echo
echo "1. stable ($STABLE - main)"
echo "2. stable ($STABLE - $KEYS)"
echo "3. stable-proposed ($STABLE - $KEYS)"
echo "4. stable-proposed-backports ($STABLE - $KEYS)"
echo "5. testing (forky - lazy security - $KEYS)"
echo "6. unstable (sid - no security - $KEYS)"
read -p "Branch: " branch
echo

# create backup
sudo cp -rf /etc/apt/sources.list /etc/apt/sources.list.bkp
echo "Backup created: /etc/apt/sources.list.bkp"
echo

if [ "$branch" = "1" ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main
deb-src $mirror $STABLE main
deb $mirror $STABLE-updates main
deb-src $mirror $STABLE-updates main
deb $mirror_sec $STABLE-security main
deb-src $mirror_sec $STABLE-security main
EOF
elif [ "$branch" = "2" ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main $KEYS
deb-src $mirror $STABLE main $KEYS
deb $mirror $STABLE-updates main $KEYS
deb-src $mirror $STABLE-updates main $KEYS
deb $mirror_sec $STABLE-security main $KEYS
deb-src $mirror_sec $STABLE-security main $KEYS
EOF
elif [ "$branch" = "3" ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main $KEYS
deb-src $mirror $STABLE main $KEYS
deb $mirror $STABLE-updates main $KEYS
deb-src $mirror $STABLE-updates main $KEYS
deb $mirror $STABLE-proposed-updates main $KEYS
deb-src $mirror $STABLE-proposed-updates main $KEYS
deb $mirror_sec $STABLE-security main $KEYS
deb-src $mirror_sec $STABLE-security main $KEYS
EOF
elif [ "$branch" = "4" ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main $KEYS
deb-src $mirror $STABLE main $KEYS
deb $mirror $STABLE-updates main $KEYS
deb-src $mirror $STABLE-updates main $KEYS
deb $mirror $STABLE-proposed-updates main $KEYS
deb-src $mirror $STABLE-proposed-updates main $KEYS
deb $mirror $STABLE-backports main $KEYS
deb-src $mirror $STABLE-backports main $KEYS
deb $mirror_sec $STABLE-security main $KEYS
deb-src $mirror_sec $STABLE-security main $KEYS
EOF
elif [ "$branch" = "5" ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror testing main $KEYS
deb-src $mirror testing main $KEYS
deb $mirror testing-updates main $KEYS
deb-src $mirror testing-updates main $KEYS
deb $mirror_sec testing-security main $KEYS
deb-src $mirror_sec testing-security main $KEYS
EOF
elif [ "$branch" = "6" ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror unstable main $KEYS
deb-src $mirror unstable main $KEYS
EOF
fi
