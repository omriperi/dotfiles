VETH1_NAME="veth1"
VETH2_NAME="veth2"
TARGET_NS="ns1"

if [ -n "$1" ]
	  then
          TARGET_NS=$1
fi

if [ -n "$2" ]
	  then
          VETH1_NAME=$2
fi


if [ -n "$3" ]
	  then
          VETH2_NAME=$3
fi

ip link add dev $VETH1_NAME type veth peer name $VETH2_NAME
ip addr add 10.0.0.1/24 dev $VETH1_NAME
ip link set $VETH1_NAME up
# Note that changing the veth state to up before moving between namespaces
# can cause problems and mess with the route table
ip link set $VETH2_NAME netns $TARGET_NS
ip netns exec $TARGET_NS ip addr add 10.0.0.2/24 dev $VETH2_NAME
ip netns exec $TARGET_NS ip link set $VETH2_NAME up
