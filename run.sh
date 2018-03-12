MATLAB_ROOT="$(whereis matlab | grep -o '[\/a-z]\{1,\}$' | xargs readlink -f | grep -P -o '.*(?=bin)')"
echo $MATLAB_ROOT
MATLAB_MAC_ADDRESS="$(cat /sys/class/net/eth0/address)"
echo $MATLAB_MAC_ADDRESS
docker run --rm -t -i -v "$MATLAB_ROOT":/usr/local/MATLAB/from-host --mac-address="$MATLAB_MAC_ADDRESS" augeas/matlab-support
