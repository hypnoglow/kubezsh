kuctx() {
    if [ -z "$1" ]; then
        while IFS= read -r line ; do
            if echo ${line} | egrep -q "\*"; then
                echo "$(tput bold)${line}$(tput sgr0)"
            else
                echo "${line}"
            fi
        done < <(kubectl config get-contexts)
        return
    fi

    kubectl config use-context $1
}
