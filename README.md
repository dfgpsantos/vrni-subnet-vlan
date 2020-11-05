Maintained by: David Santos dfgpsantos@gmail.com

# vrni-subnet-vlan
Bulk VLAN subnet mapping configuration for vRNI using bash script

Requirements:
-curl

This script runs API calls using curl via bash script.
It consists of 4 files:

-vrni-subnet-vlan.sh
The script file. You should inform the user, password, domain and vRNI platform fqdn/ip in this file.

-vlan.list
The configuration list file. You should inform the list of VLANs and subnets in this file.
This script only accepts the format subnet/mask:vlanid eg. 192.168.110.0/24:10 

-user-template.json
Do not change this file. It's the template to authenticate and create the token needed for API calls in vRNI.

-template-vlan-subnet.json
Do not change this file. It's the template to cofigure the VLANs/subnet mapping.

When running the script (sh vrni-subnet-vlan) it will authenticate and create a token in the vRNI Platform.
It'll also create some other .txt files that will be used as a API payload data or log for further reference.

-header.txt
it has the last http reader response containing 200/400 codes and JSESSION ids

-user.txt
the credentials for authentication in json format that are used as payload to API calls

-token.txt
the temporary token generated by thee first API call

-list2.txt 
the vlan subnet list after ponctuation normalization to be used as a reference list

-vlan-subnet.txt
the vlan/subnet mapping in json format that are used as payload to API calls

-results.txt
the last api call response containing all the vlan/subnet mapping conifguration



In order keep it clean the last line the script delete those files. In case troubleshooting is needed just comment that line.

Hope you enjoy and saves time with this script.
Happy mapping.

David Santos

