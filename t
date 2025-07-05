#!/bin/bash
t() {
    if [ "$#" -lt 2 ]; then
        echo "Usage:"
        echo "  t <container-id|container-name> <tool> [tool-args...]"
        echo "  t <container-id|container-name> <relative/path/inside/workspace> <tool> [tool-args...]"
        return 1
    fi

    container="$1"
    second="$2"

    # Check if the 3rd argument is a valid directory inside the container's workspace
    if [ "$#" -ge 3 ]; then
        relpath="$2"
        tool="$3"
        # Check if directory exists inside container
        USER_INSIDE=$(docker exec "$container" sh -c 'whoami || echo "root"')
        ABS_PATH="/home/$USER_INSIDE/workspace/$relpath"
        if docker exec "$container" test -d "$ABS_PATH"; then
            shift 3
            docker exec -it -w "$ABS_PATH" "$container" bash -i -c "$tool $*"
            return
        fi
    fi

    tool="$2"
    shift 2
    docker exec -it "$container" bash -i -c "$tool $*"
}

t "$@"