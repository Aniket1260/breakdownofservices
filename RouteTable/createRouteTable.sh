#!/bin/bash

# Check if the route table name, VPC ID, and region are provided as arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <route_table_name> <vpc_id> <region>"
    exit 1
fi

route_table_name="$1"
vpc_id="$2"
region="$3"

# Create the route table
echo "Creating route table $route_table_name in region $region..."
route_table_id=$(aws ec2 create-route-table --vpc-id "$vpc_id" --region "$region" --output text --query 'RouteTable.RouteTableId')

# Add a name tag to the route table
aws ec2 create-tags --resources "$route_table_id" --tags "Key=Name,Value=$route_table_name" --region "$region"

echo "Route table $route_table_name created successfully with ID $route_table_id in region $region."
