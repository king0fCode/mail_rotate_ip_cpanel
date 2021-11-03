#!/bin/sh
Count="`grep -c "Requested mail action okay" /var/log/maillog`"
echo $Count


if [ $Count -gt 200 ]
        then
                echo "More than $Count has sent"
              
ips='
    74.208.177.223
    74.208.181.220
    74.208.49.159
'
#####################################################
[ ! -f './current.txt' ] && echo '1' > ./current.txt

nIPS=0
for ip in ${ips}; do nIPS=$(( nIPS + 1 )); done

pos=$(cat ./current.txt)
counter=1
for oldip in ${ips}; do
    [ $pos -eq $counter ] && break
    counter=$(( counter + 1 ))
done

[ "$nIPS" -eq "$pos" ] && {
    echo "limit reached"
    pos=1
} || {
    echo "increment!"
    pos=$(( pos + 1 ))
}

echo "$pos"  > current.txt

counter=1
for newip in ${ips};do
    [ $pos -eq $counter ] && break
    counter=$(( counter + 1 ))
done

echo "prev: $oldip"
echo "new: $newip"

sed -ie "s/*:$oldip/*:$newip/g" /etc/mailips > /dev/null
service exim  reload

echo "new IP"
grep -i "*=" /etc/mailips
       
cp /var/log/maillog  /var/log/"maillog.backup.$(date +%Y-%m-%d_%H-%M-%S)"
# > /var/log/maillog 

        else    echo "$Count mails so far from"
                 grep -i "*=" /etc/mailips
                exit


        fi




