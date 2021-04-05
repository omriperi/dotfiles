if [ -n "$1" ]
	  then
          TARGET_NS=$1
else 
    echo "No namespace provided!"
    exit 1
fi

ip netns add $TARGET_NS