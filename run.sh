#!/bin/bash
#

display_usage() {
    echo "Usage: $0 [--url <url>] <bucket> <path>"
    echo "  --ns <namespace>   Optional Namescape argument"
    echo "  --region <region id>   Optional region argument"
    echo "  --passwd <path>   Optional passwd file argument"
    echo "  <bucket>      Bucket argument"
    echo "  <path>        Path argument"
}

options=""

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
    key="$1"

    case $key in
        --ns)
            options="$options --ns $2"
            shift # past argument
            shift # past value
            ;;
        --passwd)
            options="$options --passwd $2"
            shift # past argument
            shift # past value
            ;;
        --region)
            options="$options --region $2"
            shift # past argument
            shift # past value
            ;;
        *)
            break
            ;;
    esac
done

if [ "$#" -ne 2 ]; then
    display_usage
    exit 1
fi

bucket=$1
path=$2

docker run -d --name=s3fs -v "$path":/mnt/s3:rshared  --device /dev/fuse --cap-add SYS_ADMIN --security-opt "apparmor=unconfined" s3fs $options $bucket


