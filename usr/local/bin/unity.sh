# unity proxy設定
HTTP_PROXY=localhost
PORT=1181
# PORT=57000
# PORT=56789
PROXY_ADDRESS=$HTTP_PROXY:$PORT

export http_proxy=$PROXY_ADDRESS
export https_proxy=$PROXY_ADDRESS

/Applications/Unity/Unity.app/Contents/MacOS/Unity http_proxy=$PROXY_ADDRESS https_proxy=$PROXY_ADDRESS &
