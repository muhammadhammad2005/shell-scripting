#!/bin/bash
set -euo pipefail

check_awscli() {
	if ! command -v aws &> /dev/null; then
		echo "AWS CLI is not install. Please install it first" >&2
		return 1
	fi
}

install_awscli() {
	echo "Installing awscli on your machine."
	# Download and install awscli
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	sudo apt-get install -y unzip &> /dev/null
	unzip -q awscliv2.zip
	sudo ./aws/install

	# Verify installation
	aws --version

	# Clean up
	rm -rf awscliv2.zip ./aws
}

wait_for_instance() {
    local instance_id="$1"
    local state=""

    echo "Waiting for instance $instance_id to be in running state..."

    while true; do
        state=$(aws ec2 describe-instances \
            --instance-ids "$instance_id" \
            --query "Reservations[0].Instances[0].State.Name" \
            --output text)

        if [[ "$state" == "running" ]]; then
            echo "Instance $instance_id is now in running state."
            break
        fi

        echo "Current state: $state. Waiting..."
        sleep 10
    done
}

create_ec2_instance() {
    local ami_id="$1"
    local instance_type="$2"
    local key_name="$3"
    local subnet_id="$4"
    local security_group_ids="$5"
    local instance_name="$6"

    # Run AWS CLI command to create EC2 instance
    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name" \
        --subnet-id "$subnet_id" \
        --security-group-ids "$security_group_ids" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
        --query "Instances[0].InstanceId" \
        --output text)

    if [[ -z "$instance_id" ]]; then
        echo "EC2 instance failed to create"
        exit 1
    fi

    echo "Instance $instance_id created successfully."

    # Wait for the instance to be in the running state
    wait_for_instance "$instance_id"
}

main() {
	if ! check_awscli; then
		install_awscli || exit 1
	fi

	echo "Creating EC2 instance...."

	# Specify the parameters for creating EC2 instance
	AMI_ID="ami-09e67e426f25ce0d7"
	INSTANCE_TYPE="t2.micro"
	KEY_NAME="Shell-Scripting-for-DevOps-key"
	SUBNET_ID="subnet-00d073a7a15f9d032"
	SECURITY_GROUP_IDS="sg-097fc557d3d9bcecf"
	INSTANCE_NAME="shell-script-EC2"

	# Call the function to create the EC2 instance
	create_ec2_instance "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME"

	echo "EC2 instance creation completed."
}

main "$@"
