package test

import (
	"encoding/json"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestPolicyMultipleDestinationsConfiguration(t *testing.T) {
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/policy-dest-multiple",
		Vars: map[string]interface{}{
			"account_id": os.Getenv("NEW_RELIC_ACCOUNT_ID"),
			"enabled":    false,
		},
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Get the workflow name, enabled, and muting from output
	workflowName := terraform.Output(t, terraformOptions, "workflow_name")
	workflowEnabled := terraform.Output(t, terraformOptions, "workflow_enabled")
	workflowMuting := terraform.Output(t, terraformOptions, "workflow_muting")

	// Assert workflow name matches expected
	assert.Equal(t, "Example Workflow Multiple Destinations", workflowName)
	// Assert workflow enabled matches expected
	assert.Equal(t, "false", workflowEnabled)
	// Assert workflow muting matches expected
	assert.Equal(t, "DONT_NOTIFY_FULLY_OR_PARTIALLY_MUTED_ISSUES", workflowMuting)

	expectedEmailDestinations := []map[string]string{
		{
			"email_addresses": "robert.example@fake.com",
			"email_subject":   "Alert Notification for {{ issueTitle }}",
			"email_details":   "View Details at {{ issueUrl }}",
		},
	}

	// Get the email destinations output as json
	emailDestinationsOutput := terraform.OutputJson(t, terraformOptions, "email_destinations")

	var emailDestinations []map[string]string
	err := json.Unmarshal([]byte(emailDestinationsOutput), &emailDestinations)
	if err != nil {
		t.Fatal(err)
	}

	for i, x := range expectedEmailDestinations {
		assert.Equal(t, x["email_addresses"], emailDestinations[i]["email_addresses"])
		assert.Equal(t, x["email_subject"], emailDestinations[i]["email_subject"])
		assert.Equal(t, x["email_details"], emailDestinations[i]["email_details"])
	}

	expectedWebhookHeaders := `{
  "x-api-key": "secure_string_for_security"
}
`

	expectedWebhookPayload := `{
  "id": {{ json issueId }},
  "issueUrl": {{ json issuePageUrl }},
  "title": {{ json annotations.title.[0] }},
  "priority": {{ json priority }},
  "state": {{ json state }},
  "trigger": {{ json triggerEvent }},
  "alertPolicyNames": {{ json accumulations.policyName }},
  "alertConditionNames": {{ json accumulations.conditionName }},
  "workflowName": {{ json workflowName }},
  "supportGroup": Site Reliability Engineering
}
`

	expectedWebhookDestinations := []map[string]string{
		{
			"webhook_url":     "https://api.monitoring.com",
			"webhook_headers": expectedWebhookHeaders,
			"webhook_payload": expectedWebhookPayload,
		},
	}

	// Get the webhook destinations output as json
	webhookDestinationsOutput := terraform.OutputJson(t, terraformOptions, "webhook_destinations")

	var webhookDestinations []map[string]string
	err = json.Unmarshal([]byte(webhookDestinationsOutput), &webhookDestinations)

	if err != nil {
		t.Fatal(err)
	}

	for i, x := range expectedWebhookDestinations {
		assert.Equal(t, x["webhook_url"], webhookDestinations[i]["webhook_url"])
		assert.Equal(t, x["webhook_headers"], webhookDestinations[i]["webhook_headers"])
		assert.Equal(t, x["webhook_payload"], webhookDestinations[i]["webhook_payload"])
	}
}
