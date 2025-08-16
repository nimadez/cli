#!/bin/bash
#
# Generate debian sources.list

# You need all these keys for the drivers to work properly
STABLE="trixie"
KEYS="contrib non-free non-free-firmware"

read -p "Mirror URL (enter=http://deb.debian.org/debian/): " mirror
if [ "$mirror" = "" ]; then
    mirror="http://deb.debian.org/debian/"
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
read -p "press enter to continue ..." p
echo

if [ "$branch" -eq 1 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main
deb-src $mirror $STABLE main
deb $mirror $STABLE-updates main
deb-src $mirror $STABLE-updates main
deb http://security.debian.org/debian-security/ $STABLE-security main
deb-src http://security.debian.org/debian-security/ $STABLE-security main
EOF
elif [ "$branch" -eq 2 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main $KEYS
deb-src $mirror $STABLE main $KEYS
deb $mirror $STABLE-updates main $KEYS
deb-src $mirror $STABLE-updates main $KEYS
deb http://security.debian.org/debian-security/ $STABLE-security main $KEYS
deb-src http://security.debian.org/debian-security/ $STABLE-security main $KEYS
EOF
elif [ "$branch" -eq 3 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main $KEYS
deb-src $mirror $STABLE main $KEYS
deb $mirror $STABLE-updates main $KEYS
deb-src $mirror $STABLE-updates main $KEYS
deb $mirror $STABLE-proposed-updates main $KEYS
deb-src $mirror $STABLE-proposed-updates main $KEYS
deb http://security.debian.org/debian-security/ $STABLE-security main $KEYS
deb-src http://security.debian.org/debian-security/ $STABLE-security main $KEYS
EOF
elif [ "$branch" -eq 4 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror $STABLE main $KEYS
deb-src $mirror $STABLE main $KEYS
deb $mirror $STABLE-updates main $KEYS
deb-src $mirror $STABLE-updates main $KEYS
deb $mirror $STABLE-proposed-updates main $KEYS
deb-src $mirror $STABLE-proposed-updates main $KEYS
deb $mirror $STABLE-backports main $KEYS
deb-src $mirror $STABLE-backports main $KEYS
deb http://security.debian.org/debian-security/ $STABLE-security main $KEYS
deb-src http://security.debian.org/debian-security/ $STABLE-security main $KEYS
EOF
elif [ "$branch" -eq 5 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror testing main $KEYS
deb-src $mirror testing main $KEYS
deb $mirror testing-updates main $KEYS
deb-src $mirror testing-updates main $KEYS
deb http://security.debian.org/debian-security/ testing-security main $KEYS
deb-src http://security.debian.org/debian-security/ testing-security main $KEYS
EOF
elif [ "$branch" -eq 6 ]; then
cat <<EOF | sudo tee /etc/apt/sources.list
deb $mirror unstable main $KEYS
deb-src $mirror unstable main $KEYS
EOF
fi
