if [ -n "$1" ]
	  then
          TARGET_NS=$1
else 
    echo "No namespace provided!"
    exit 1
fi

ip netns del $TARGET_NS