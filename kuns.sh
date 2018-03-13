kuns() {
    if [ -z "$1" ]; then
        local current_namespace
        current_namespace=$(kubectl config get-contexts | egrep "\*" | awk '{print $NF}')

        while IFS= read -r line ; do
            if echo ${line} | grep "NAME" | grep "STATUS" | grep -q "AGE"; then
                echo "CURRENT   ${line}"
            elif [ "$(echo ${line} | awk '{print $1}')" = "$current_namespace" ]; then
                echo "$(tput bold)*         ${line}$(tput sgr0)"
            else
                echo "          ${line}"
            fi
        done < <(kubectl get namespaces)
        return
    fi

    kubectl config set-context "$(kubectl config current-context)" --namespace $1
}
