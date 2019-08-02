#!/usr/bin/bash
# variaveis de entrada:
# $1 = arquivo com objetos json
# $2 = classe a ser importada
# ./transformjsontoxml.bash lista.json ProcessGroup
# Lera os arquivos processgroup.json, remoteprocessgroup.json, processors.json
# e gerara um arquivo assets.xml para importar no openigc
# ./transformjsontoxml.bash 

saida=assets.xml
cont=0

echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" > $saida
echo "<doc xmlns=\"http://www.ibm.com/iis/flow-doc\">" >> $saida
echo "    <assets>" >> $saida

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
     name=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     sed -i "s/NOMEOBJETO/$name/" $saida
     echo "            <attribute name=\"name\" value=\"$name\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "parentGroupId" ]
   then
     parentGroupId=`echo $linha | cut -d: -f2 | cut -d\" -f2`
     echo "            <attribute name=\"\$parentGroupId\" value=\"$parentGroupId\" />" >> $saida
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "URL" ]
   then
echo $linha
     URL=`echo $linha | cut -d: -f2- | cut -d\, -f1`
     echo "            <attribute name=\"\$URL\" value=\"$URL\" />" >> $saida
echo $URL
   elif [ `echo $linha | cut -d: -f1 | cut -d\" -f2` == "Transmiting" ]
   then
     Transmiting=`echo $linha | cut -d: -f2 | cut -d\, -f1`
     echo "            <attribute name=\"\$Transmiting\" value=\"$Transmiting\" />" >> $saida
echo $Transmiting
   elif [ "$linha" = "}" ] || [ "$linha" = "}," ]
   then
     echo "        </asset>" >> $saida
   fi
done < remoteprocessgroup.json

echo "    </assets>"  >> $saida
echo "    <importAction partialAssetIDs=\"a1\" completeAssetIDs=\"a$cont\"/>"  >> $saida
echo "</doc> "  >> $saida
