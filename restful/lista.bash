#!/usr/bin/bash
export PGROUP=`/root/restful/resources.bash | jq . | grep  "\/process-groups"  | egrep -v "data|policies" | cut -d/ -f3 | cut -d\" -f1`

#export PGROUP=`/root/restful/resources.bash | jq '.resources[] | select(.identifier | startswith("/process-groups/")) | .identifier'`
#/root/restful/resources.bash | jq -C . | grep process-groups | egrep -v "data|policies" | cut -d/ -f3 | cut -d\" -f1

# Inserir o processo group Id como argumento de entrada
for i in $PGROUP
do
   /root/restful/process-group.bash $i | jq '. | {id: .id, name: .component.name, comments: .component.comments, runningCount: .runningCount, stoppedCount: .stoppedCount}'
done > processgroup.json

for i in $PGROUP
do
   /root/restful/process-group-processor.bash $i | jq '[.processors[] | {name: .component.name, id: .id, parentGroupId: .component.parentGroupId, type: .component.type, state: .component.state, comments: .component.config.comments, inputRequirement: .component.inputRequirement}]'
done > processors.json
