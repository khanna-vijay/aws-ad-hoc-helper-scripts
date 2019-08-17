clear
echo "Warning.. This will delte all CloudWatch Log Groups.. and is DANGEROUS"

read -p "Are you really sure, if yes type the sum of 3 + 5 " resp_del

echo $resp_del

if [ $resp_del == 'eight' ]  
    then
         echo "Deleting the Log Groups now"
         aws logs describe-log-groups  | jq '.logGroups[].logGroupName' > all_loggroup_names.json
         input="all_loggroup_names.json"
            while IFS= read -r line
            do
              
              if [[ $line == *'CloudTrail'* ]]
                then
                    echo "* * * Not Deleting the CloudTrail Logs"
              else 
                    echo "Deleting the Log Group : " $line
                   lg=`echo $line | tr -d '"'`
                    aws logs delete-log-group --log-group-name $lg
            fi
              
            done < "$input"
    else
        echo "Sparing the Logs"
fi

