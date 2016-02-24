while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-p,                       specify a port to be mapped"
                        echo "-m,                       specify memory of vagrant vm"
                        echo "-n,                       specify name of your farm"
                        echo "-c,                       specify name of your docker image"
                        exit 0
                        ;;
                -p)
                        shift
                        if test $# -gt 0; then
                                export PORT=$1
                        else
                                echo "no port specified"
                                exit 1
                        fi
                        shift
                        ;;
                -m)
                        shift
                        if test $# -gt 0; then
                                export MEMORY=$1
                        fi
                        shift
                        ;;
                -c)     
                        shift
                        if test $# -gt 0; then
                                export CONTAINERNAME=$1
                        else
                                echo "no docker image name specified"
                                exit 1
                        fi
                        shift
                        ;;
                -n)     
                        shift
                        if test $# -gt 0; then
                                export NAME=$1
                        else
                                echo "no farm name specified"
                                exit 1
                        fi
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done

#Assign defaults, check if required values are set
if [ -z "$PORT" ]; then
    echo "no port mapping defined"
    exit 1
fi

if [ -z "$NAME" ]; then
    echo "no farm name defined"
    exit 1
fi

if [ -z "$CONTAINERNAME" ]; then
    echo "no docker image defined"
    exit 1
fi

if [ -z "$MEMORY" ]; then
    echo "no memory defined, setting default of 1024M"
    export MEMORY="1024"
fi

mkdir -p $NAME
touch $NAME/Vagrantfile
touch $NAME/init-$NAME.sh

echo "-- changing vagrant file to create a port mapping to $PORT, backup saved to Vagrantfile.bak"
echo "---- adding port mapping to provisioning script in init.sh as well"
echo "-- setting memory to $MEMORY"
sed -e s/FARMPORT/$PORT/g \
    -e s/FARMMEMORY/$MEMORY/g \
    -e s/FARMNAME/$NAME/g \
    Vagrantfile > $NAME/Vagrantfile

sed -e s/FARMPORT/$PORT/g \
    -e s/FARMIMAGE/$CONTAINERNAME/g \
    init.sh > $NAME/init-$NAME.sh

echo "---STARTING VAGRANT VM---"

