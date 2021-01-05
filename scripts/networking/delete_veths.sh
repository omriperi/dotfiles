VETH1_NAME="veth1"

if [ -n "$1" ]
	  then
          VETH1_NAME=$1
fi


ip link del $VETH1_NAME 
