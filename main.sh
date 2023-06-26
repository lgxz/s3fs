#!/bin/sh

ns="axb5arhpafp8"
region="eu-amsterdam-1"
passwd="/root/.passwd-s3fs"
dest="/mnt/s3"

# Function to display script usage
display_usage() {
    echo "Usage: $0 [--url <url>] <bucket> <path>"
    echo "  --ns <namespace>   Optional Namescape argument"
    echo "  --region <region id>   Optional region argument"
    echo "  --passwd <path>   Optional passwd file argument"
    echo "  <bucket>      Bucket argument"
    echo "  <path>        Path argument"
}

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
    key="$1"

    case $key in
        --ns)
            ns="$2"
            shift # past argument
            shift # past value
            ;;
        --passwd)
            passwd="$2"
            shift # past argument
            shift # past value
            ;;
        --region)
            region="$2"
            shift # past argument
            shift # past value
            ;;
        *)
            break
            ;;
    esac
done

# Check if required arguments are provided
if [ "$#" -ne 1 ]; then
    display_usage
    exit 1
fi

# Assign positional arguments
bucket="$1"
url="https://$ns.compat.objectstorage.$region.oraclecloud.com"
options="-o passwd_file=$passwd -o url=$url -o use_path_request_style -o kernel_cache -o multipart_size=128 -o parallel_count=50 -o multireq_max=100 -o max_background=1000"

# Display the arguments
echo "Use $url and $passwd"

s3fs "$bucket" "$dest" $options -f

