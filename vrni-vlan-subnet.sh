#!/bin/bash

USER=user@corp.local
PASSWORD=password
DOMAINTYPE=LOCAL
DOMAINVALUE=localhost
VRNI=vrni-plat.corp.local
LIST=vlan.list
LIST2=list2.txt

#please remove your credentials info after using the script

rm -rf *.txt

sed s/USER/$USER/ template-user.json > user.txt
sed -i s/PASSWORD/$PASSWORD/ user.txt
sed -i s/DOMAINTYPE/$DOMAINTYPE/ user.txt
sed -i s/DOMAINVALUE/$DOMAINVALUE/ user.txt

curl -i -k -b cookie.txt -D header.txt -H "Content-Type: application/json" --data @user.txt -X POST https://$VRNI/api/ni/auth/token | grep token >  token.txt

sed -i 's/,/:/g' token.txt
sed -i 's/"//g' token.txt
TOKEN=`cut -d":" -f2 token.txt`
echo $TOKEN

curl -i -k -H "Authorization: NetworkInsight $TOKEN" -H "Content-Type: application/json" -X GET https://$VRNI/api/ni/data-sources/vcenters

sed 's/\./:/g' $LIST > list2.txt
sed -i 's/\//:/g' list2.txt

for LINE in `cat $LIST2`

do

VLANID=`echo $LINE | cut -f6 -d":"`
SUBNET1=`echo $LINE | cut -f1 -d":"`
SUBNET2=`echo $LINE | cut -f2 -d":"`
SUBNET3=`echo $LINE | cut -f3 -d":"`
SUBNET4=`echo $LINE | cut -f4 -d":"`
SUBNET5=`echo $LINE | cut -f5 -d":"`

sed s/VLANID/$VLANID/ template-vlan-subnet.json > vlan-subnet.txt
sed -i s/SUBNET1/$SUBNET1/ vlan-subnet.txt
sed -i s/SUBNET2/$SUBNET2/ vlan-subnet.txt
sed -i s/SUBNET3/$SUBNET3/ vlan-subnet.txt
sed -i s/SUBNET4/$SUBNET4/ vlan-subnet.txt
sed -i s/SUBNET5/$SUBNET5/ vlan-subnet.txt

curl -i -k -H "Authorization: NetworkInsight $TOKEN" -H "Content-Type: application/json" --data @vlan-subnet.txt -X POST https://$VRNI/api/ni/settings/subnet-mappings

sleep 1

done

curl -i -k -H "Authorization: NetworkInsight $TOKEN" -H "Content-Type: application/json" -X GET https://$VRNI/api/ni/settings/subnet-mappings > result.txt

RESULT=result.txt

echo `cat $RESULT`

curl -i -k -H "Authorization: NetworkInsight $TOKEN" -H "Content-Type: application/json" -X DELETE https://$VRNI/api/ni/auth/token

rm -rf user.txt token.txt list2.txt header.txt vlan-subnet.txt

exit 0
