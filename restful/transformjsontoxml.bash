#!/usr/bin/bash
# variaveis de entrada:
# $1 = arquivo com objetos json
# $2 = classe a ser importada
# ./transformjsontoxml.bash lista.json ProcessGroup
# Lera os arquivos processgroup.json, remoteprocessgroup.json, processors.json
# e gerara um arquivo assets.xml para importar no openigc
# ./transformjsontoxml.bash 

#curl -s --insecure -H "Accept:application/json" -u alo:alo https://labigor.md2.com:9446/ibm/iis/igc-rest/v1/types | jq -C .
#curl -s --insecure -H "Accept:application/json" -u alo:alo https://labigor.md2.com:9446/ibm/iis/igc-rest/v1/bundles | jq -C .


saida=assets.xml
cont=0

echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" > $saida
echo "<doc xmlns=\"http://www.ibm.com/iis/flow-doc\">" >> $saida
echo "    <assets>" >> $saida

# --------------------- Process Group ---------------------
classe=ProcessGroup

while read -r linha
do
   if [ "$linha" = "{" ]
   then
     cont=$(( cont + 1 ))
     echo "        <asset class=\"\$NiFi-$classe\" repr=\"NOMEOBJETO\" ID=\"a$cont\">" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "id" ]
   then
     id=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$id\" value=\"$id\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "parentGroupId" ]
   then
     parentGroupId=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$parentGroupId\" value=\"$parentGroupId\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "name" ]
   then
     name=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     sed -i "s/NOMEOBJETO/$name/" $saida
     echo "            <attribute name=\"name\" value=\"$name\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "comments" ]
   then
     comments=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     echo "            <attribute name=\"\$comments\" value=\"$comments\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "runningCount" ]
   then
     runningCount=`echo $linha | cut -d: -f2 | cut -d\, -f1`
     echo "            <attribute name=\"\$runningCount\" value=\"$runningCount\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "stoppedCount" ]
   then
     stoppedCount=`echo $linha | cut -d: -f2 | cut -d\, -f1`
     echo "            <attribute name=\"\$stoppedCount\" value=\"$stoppedCount\" />" >> $saida
   elif [ "$linha" = "}" ] || [ "$linha" = "}," ]
   then
     echo "        </asset>" >> $saida
   fi
done < processgroup.json


# --------------------- Remote Process Group ---------------------
classe=RemoteProcessGroup

while read -r linha
do
   if [ "$linha" = "{" ]
   then
     cont=$(( cont + 1 ))
     echo "        <asset class=\"\$NiFi-$classe\" repr=\"NOMEOBJETO\" ID=\"a$cont\">" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "id" ]
   then
     id=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$id\" value=\"$id\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "name" ]
   then
     name=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     sed -i "s#NOMEOBJETO#$name#g" $saida
     echo "            <attribute name=\"name\" value=\"$name\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "parentGroupId" ]
   then
     parentGroupId=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$parentGroupId\" value=\"$parentGroupId\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "URL" ]
   then
     URL=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     echo "            <attribute name=\"\$URL\" value=\"$URL\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "Transmiting" ]
   then
     Transmiting=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     echo "            <attribute name=\"\$Transmiting\" value=\"$Transmiting\" />" >> $saida
   elif [ "$linha" = "}" ] || [ "$linha" = "}," ]
   then
     echo "        </asset>" >> $saida
   fi
done < remoteprocessgroup.json


# --------------------- Processors ---------------------
classe=Processor

while read -r linha
do
   if [ "$linha" = "{" ]
   then
     cont=$(( cont + 1 ))
     echo "        <asset class=\"\$NiFi-$classe\" repr=\"NOMEOBJETO\" ID=\"a$cont\">" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "id" ]
   then
     id=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$id\" value=\"$id\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "name" ]
   then
     name=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     sed -i "s/NOMEOBJETO/$name/" $saida
     echo "            <attribute name=\"name\" value=\"$name\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "parentGroupId" ]
   then
     parentGroupId=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$parentGroupId\" value=\"$parentGroupId\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "type" ]
   then
     type=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     echo "            <attribute name=\"\$type\" value=\"$type\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "state" ]
   then
     state=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     echo "            <attribute name=\"\$state\" value=\"$state\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "comments" ]
   then
     comments=`echo $linha | cut -d: -f2- | cut -d\" -f2`
     echo "            <attribute name=\"\$comments\" value=\"$comments\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "inputRequirement" ]
   then
     inputRequirement=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$inputRequirement\" value=\"$inputRequirement\" />" >> $saida
   elif [ "$linha" = "}" ] || [ "$linha" = "}," ]
   then
     echo "        </asset>" >> $saida
   fi
done < processors.json



echo "    </assets>"  >> $saida
echo "    <importAction partialAssetIDs=\"a1\" completeAssetIDs=\"a$cont\"/>"  >> $saida
echo "</doc> "  >> $saida
