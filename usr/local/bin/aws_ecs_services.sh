#/bin/bash -eu

while read line
do
  clusters=("${clusters[@]}" $line)
done

header=(ServiceId,Status,ServiceType,TaskDefinition,DesTasks,PedTasks,RunTasks,PlaceStrategy,PlaceConstraints,LaunchType,DepCfgMin,DepCfgMax,Deployements,CreatedAt)

function printLine () {
  arr=$1
  echo "$(IFS=,; echo "${arr[*]}")"
}

printLine $header

for clusterId in "${clusters[@]}" ; do
  for service in $(aws ecs list-services --cluster $clusterId | jq '.serviceArns[]'); do
    serviceId=$(echo $service | sed 's/^[^/]*\///' | sed 's/"$//')

    serviceInfo=$(aws ecs describe-services --cluster $clusterId --services $serviceId | jq '.services[0]')
    status=$(echo $serviceInfo|jq '.status')
    serviceType=$(echo $serviceInfo|jq '.schedulingStrategy')
    taskDefinition=$(echo $serviceInfo|jq '.taskDefinition'| sed 's/^[^/]*\///' | sed 's/"$//')
    desiredTasks=$(echo $serviceInfo|jq '.desiredCount')
    pendingTasks=$(echo $serviceInfo|jq '.pendingCount')
    runningTasks=$(echo $serviceInfo|jq '.runningCount')
    launchType=$(echo $serviceInfo|jq '.launchType')
    events=$(echo $serviceInfo|jq '.events')

    # Events

    # Deployments
    placementStrategy=$(echo $serviceInfo|jq '.placementStrategy | join(",")')
    placementConstraints=$(echo $serviceInfo|jq '.placementConstraints | join(",")')
    deploymentConfigMinimumHealthyPercent=$(echo $serviceInfo|jq '.deploymentConfiguration.minimumHealthyPercent')
    deploymentConfigMaximumPercent=$(echo $serviceInfo|jq '.deploymentConfiguration.maximumPercent')
    deployments=$(
      echo $serviceInfo \
        | jq '.deployments[] | [.status, (.taskDefinition| gsub( "^[^//]+/"; "")), .desiredCount, .pendingCount, .runningCount, (.createdAt|.+32400|todate[0:16])] | join("|")'
    )

    createdAt=$(echo $serviceInfo|jq '.createdAt|.+32400|todate[0:16]')

    for d in $deployments; do
      data=($serviceId,$status,$serviceType,$taskDefinition,$desiredTasks,$pendingTasks,$runningTasks,$placementStrategy,$placementConstraints,$launchType,$deploymentConfigMinimumHealthyPercent,$deploymentConfigMaximumPercent,$d,$createdAt)
      printLine $data
    done
  done
done

