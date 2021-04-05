# Displaying run commands
set -ex

VETH1_NAME="veth1"
VETH2_NAME="veth2"
NS1="ns1"
NS2="ns2"

if [ -n "$1" ]
	  then
          NS1=$1
else 
    echo "No namespace provided, exiting!"
    exit 1
fi

if [ -n "$2" ]
	  then
          NS2=$2
else 
    echo "No namespace provided, exiting!"
    exit 1
fi

if [ -n "$3" ]
	  then
          VETH1_NAME=$3
fi


if [ -n "$4" ]
	  then
          VETH2_NAME=$4
fi

ip link add dev $VETH1_NAME type veth peer name $VETH2_NAME
ip link set $VETH1_NAME netns $NS1
ip netns exec $NS1 ip addr add 10.0.0.1/24 dev $VETH1_NAME
ip netns exec $NS1 ip link set $VETH1_NAME up
# Note that changing the veth state to up before moving between namespaces
# can cause problems and mess with the route table
ip link set $VETH2_NAME netns $NS2
ip netns exec $NS2 ip addr add 10.0.0.2/24 dev $VETH2_NAME
ip netns exec $NS2 ip link set $VETH2_NAME up
