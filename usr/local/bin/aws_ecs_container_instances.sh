#/bin/bash -eu

while read line
do
  clusters=("${clusters[@]}" $line)
done

header=(ClusterId,ContainerId,EC2InstanceId,AvailabilityZone,InstanceType,AgentConnected,Status,RunningTasks,RemainingCPU,RemainingMemory,AgentVersion,DockerVersion,RegisteredAt)

function printLine () {
  arr=$1
  echo "$(IFS=,; echo "${arr[*]}")"
}

printLine $header

for clusterId in "${clusters[@]}" ; do
  for container in $(aws ecs list-container-instances --cluster $clusterId | jq '.containerInstanceArns[]'); do
    containerId=$(echo $container | sed 's/^[^/]*\///' | sed 's/"$//')

    instanceInfo=$(aws ecs describe-container-instances --cluster $clusterId --container-instances $containerId)

    instanceId=$(echo $instanceInfo|jq -r '.containerInstances[].ec2InstanceId')

    availabilityZone=$(echo $instanceInfo|jq '.containerInstances[].attributes[] | select(.name == "ecs.availability-zone") | .value')
    instanceType=$(echo $instanceInfo|jq '.containerInstances[].attributes[] | select(.name == "ecs.instance-type") | .value')

    agentConnected=$(echo $instanceInfo | jq '.containerInstances[].agentConnected')
    status=$(echo $instanceInfo | jq '.containerInstances[].status')

    runningTasks=$(echo $instanceInfo | jq '.containerInstances[].runningTasksCount')

    cpuAvailable=$(echo $instanceInfo|jq '.containerInstances[].remainingResources[] | select(.name == "CPU") | .integerValue')
    memoryAvailable=$(echo $instanceInfo|jq '.containerInstances[].remainingResources[] | select(.name == "MEMORY") | .integerValue')

    agentVersion=$(echo $instanceInfo|jq '.containerInstances[].versionInfo.agentVersion')
    dockerVersion=$(echo $instanceInfo|jq '.containerInstances[].versionInfo.dockerVersion' | sed 's/DockerVersion: //')

    registeredAt=$(echo $instanceInfo|jq '.containerInstances[].registeredAt')
    registeredDate=$(gdate -d "@${registeredAt}" "+%Y/%m/%dT%H:%M")


    data=($clusterId,$containerId,$instanceId,$availabilityZone,$instanceType,$agentConnected,$status,$runningTasks,$cpuAvailable,$memoryAvailable,$agentVersion,$dockerVersion,$registeredDate)
    printLine $data
  done
done
