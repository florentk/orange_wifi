COOKIE_FILE=/tmp/orange_login
USER=$1
PWD=$2

if [ -n "$USER" ]; then 
  rm -f $COOKIE_FILE
  echo "init cookie"
  curl -s -c $COOKIE_FILE https://login.orange.fr > out
  echo "valid user $USER"
  curl -s -c $COOKIE_FILE -b $COOKIE_FILE  -d '{"login":"'$USER'","params":{},"mem":true,"force":""}' https://login.orange.fr/front/login >> out
  echo "valid password"
  curl -s -c $COOKIE_FILE -b $COOKIE_FILE  -d '{"login":"'$USER'","password":"'$PWD'","params":{},"remember":true}' https://login.orange.fr/front/password >> out

  echo "get wifi home page"
  curl -s -c $COOKIE_FILE -b $COOKIE_FILE https://hautdebitmobile.orange.fr:8443/home >> out
  echo "connection ..."
  curl -s -c $COOKIE_FILE -b $COOKIE_FILE 'https://hautdebitmobile.orange.fr:8443/home/wassup?isCgu=on&hidden_isCgu=&doCheckCgu=1'
else
  echo "disconnect"
  curl -b $COOKIE_FILE https://hautdebitmobile.orange.fr:8443/home/disconnect
fi



