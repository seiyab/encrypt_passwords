function encpass() {
    if [ -z "$2" ]; then
        echo "Short of argument"
    elif [ -f $MY_PASSWORDS"/"$1".txt.enc" ]; then
        echo "Password already exists."
    else
        echo $2 | openssl enc -aes-256-cbc -base64 -md sha1 -out $MY_PASSWORDS"/"$1".txt.enc"
    fi
}

function genpass() {
    if [ -z "$1" ]; then
        echo "Short of argument"
    elif [ -f $MY_PASSWORDS"/"$1".txt.enc" ]; then
        echo "Password already exists."
    else
        openssl rand -base64 12 | openssl enc -aes-256-cbc -base64 -md sha1 -out $MY_PASSWORDS"/"$1".txt.enc" \
     && chmod 400 $MY_PASSWORDS"/"$1".txt.enc"
    fi
}

function decpass() {
    if [ -z "$1" ]; then
        echo "Short of argument"
    elif [ -f $MY_PASSWORDS"/"$1".txt.enc" ]; then
        openssl enc -d -aes-256-cbc -base64 -md sha1 -in $MY_PASSWORDS"/"$1".txt.enc"
    else
        echo "Password doesn't exist."
    fi
}

function uppass() {
    rsync --chmod=u+w $MY_PASSWORDS/*.txt.enc vps:/home/core/pass/
}
