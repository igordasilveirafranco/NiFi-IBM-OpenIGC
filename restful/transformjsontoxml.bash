#!/usr/bin/bash
# variaveis de entrada:
# $1 = arquivo com objetos json
# $2 = classe a ser importada
# ./transformjsontoxml.bash lista.json ProcessGroup

#curl -s --insecure -H "Accept:application/json" -u alo:alo https://labigor.md2.com:9446/ibm/iis/igc-rest/v1/types | jq -C .
#curl -s --insecure -H "Accept:application/json" -u alo:alo https://labigor.md2.com:9446/ibm/iis/igc-rest/v1/bundles | jq -C .

echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" > $1.xml
echo "<doc xmlns=\"http://www.ibm.com/iis/flow-doc\">" >> $1.xml
echo "    <assets>" >> $1.xml

cont=0

while read -r linha
do
   if [ "$linha" = "{" ]
   then
     cont=$(( cont + 1 ))
     echo "        <asset class=\"\$NiFi-$2\" repr=\"NOMEOBJETO\" ID=\"a$cont\">" >> $1.xml
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "id" ]
   then
     id=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$id\" value=\"$id\" />" >> $1.xml
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "name" ]
   then
     name=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     sed -i "s/NOMEOBJETO/$name/" $1.xml
     echo "            <attribute name=\"name\" value=\"$name\" />" >> $1.xml
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "comments" ]
   then
     comments=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$comments\" value=\"$comments\" />" >> $1.xml
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "runningCount" ]
   then
     runningCount=`echo $linha | cut -d: -f2 | cut -d\, -f1`
     echo "            <attribute name=\"\$runningCount\" value=\"$runningCount\" />" >> $1.xml
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "stoppedCount" ]
   then
     stoppedCount=`echo $linha | cut -d: -f2 | cut -d\, -f1`
     echo "            <attribute name=\"\$stoppedCount\" value=\"$stoppedCount\" />" >> $1.xml
   elif [ "$linha" = "}" ]
   then
     echo "        </asset>" >> $1.xml
   fi
done < $1

echo "    </assets>"  >> $1.xml
echo "    <importAction partialAssetIDs=\"a1\" completeAssetIDs=\"a$cont\"/>"  >> $1.xml
echo "</doc> "  >> $1.xml
