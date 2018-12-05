#!/bin/bash

ARGS="list,host:"

## read cmd params
opts=$(getopt \
    --longoptions "$(echo $ARGS)" \
    --name "$(basename "$0")" \
    --options "" \
    -- "$@"
)

eval set --$opts

getHostList() {
    hlist=$(gcloud compute instances list \
        --format="table[no-heading](name,INTERNAL_IP,EXTERNAL_IP)" \
        --filter="STATUS=RUNNING" | awk '{print "\""$1"\",\""$2"\",\""$3"\""}')
    
    hosts="{\n \"hosts\": [\n"
    
    meta="  \"_meta\" : {\n    \"hostvars\": {\n"
    
    for el in $hlist; do
     host=$(echo $el | cut -d ',' -f1)
     ext_ip=$(echo $el | cut -d ',' -f3)
     int_ip=$(echo $el | cut -d ',' -f2)
     isDB=$(echo $host | grep -q -e "^\"db.*"; echo $?)

     hosts=`echo "$hosts     $host,\n"`
     meta=$(echo "$meta      $host: {\n        \"ansible_host\":  $ext_ip")
     if [ $isDB -eq 0 ]; then
       meta=$(echo "$meta,\n        \"mongo_bind_ip\": $int_ip\n")
     fi
     meta=$(echo "$meta\n      },\n")
    done
    hosts=$(echo "$hosts" | sed 's/,\\n$/\\n  ],/')
    meta=$(echo "$meta" | sed 's/,\\n$/\\n    }\\n/')
    echo -e "$hosts\n$meta  }\n}"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --list)
            shift 2
            getHostList
            ;;
        --host)
            shift 2
            echo '{"_meta": {"hostvars": {}}}'
            ;;
        *)
            break
            ;;
    esac
done
