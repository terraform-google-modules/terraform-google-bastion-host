#!/usr/bin/env bats

# #################################### #
#             Terraform tests          #
# #################################### #

@test "Ensure that Terraform configures the dirs and download the plugins" {

  run terraform init
  [ "$status" -eq 0 ]
}

@test "Ensure that Terraform updates the plugins" {

  run terraform get
  echo "status = ${status}"
  echo "output = ${output}"
  [ "$status" -eq 0 ]
}

@test "Terraform plan, ensure connection and creation of resources" {

  run terraform plan
  [ "$status" -eq 0 ]
  [[ "$output" =~ 6\ to\ add ]]
  [[ "$output" =~ 0\ to\ change ]]
  [[ "$output" =~ 0\ to\ destroy ]]
}

@test "Terraform apply" {

  run terraform apply -auto-approve
  [ "$status" -eq 0 ]
  [[ "$output" =~ 6\ added ]]
  [[ "$output" =~ 0\ changed ]]
  [[ "$output" =~ 0\ destroyed ]]
  
}

# #################################### #
#             gcloud tests             #
# #################################### #


@test "Test that the service accont was created" {

  export SERVICE_ACCOUNT="$(terraform output service_account)"
  export PROJECT_ID="$(terraform output bastion_project)"

    run gcloud --project $PROJECT_ID iam service-accounts describe $SERVICE_ACCOUNT --format='get(email)'[no-pad]
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" = "$SERVICE_ACCOUNT" ]]
 
}

@test "Test that the firewall rule was created" {

  export FIREWALL_NAME="$(terraform output firewall_name)"
  export NETWORK_NAME="$(terraform output network_name)"
  export PROJECT_ID="$(terraform output bastion_project)"
    
    run gcloud --project $PROJECT_ID compute firewall-rules describe $FIREWALL_NAME --format='get(targetServiceAccounts)'[no-pad]
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" = "$SERVICE_ACCOUNT" ]]

    run gcloud --project $PROJECT_ID compute firewall-rules describe $FIREWALL_NAME --format='get(allowed.ports)'[no-pad]
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" = "[u'22']" ]]

    run gcloud --project $PROJECT_ID compute firewall-rules describe $FIREWALL_NAME --format='get(network)'[no-pad]
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" = "https://www.googleapis.com/compute/v1/projects/$PROJECT_ID/global/networks/$NETWORK_NAME" ]]
}

@test "Test that the bastion instance was created" {
    
  export BASTION_NAME="$(terraform output bastion_name)"
  export BASTION_ZONE="$(terraform output bastion_zone)"
  export PROJECT_ID="$(terraform output bastion_project)"

    run gcloud --project $PROJECT_ID compute instances describe $BASTION_NAME --zone $BASTION_ZONE --format='get(name)'[no-pad]
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" = "$BASTION_NAME" ]]
}


# #################################### #
#      Terraform destroy test          #
# #################################### #

@test "Terraform destroy" {

  run terraform destroy -force
  [ "$status" -eq 0 ]
  [[ "$output" =~ 6\ destroyed ]]
}
