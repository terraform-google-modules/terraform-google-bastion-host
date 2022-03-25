package iap_tunneling

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/stretchr/testify/assert"
)

func TestIapTunneling(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		instance := gcloud.Runf(t, "compute instances describe iap-test-instance --zone us-west1-a --project %s", projectId)
		assert.Equal("RUNNING", instance.Get("status").String(), "is running")
		osLogin := utils.GetFirstMatchResult(t, instance.Get("metadata.items").Array(), "key", "enable-oslogin")
		assert.Equal("TRUE", osLogin.Get("value").String(), "os-login is enabled")

		fw := gcloud.Runf(t, "compute firewall-rules describe allow-ssh-from-iap-to-tunnel --project %s", projectId)
		assert.Equal("35.235.240.0/20", fw.Get("sourceRanges").Array()[0].String(), "has expected sourceRanges")
		assert.Equal("INGRESS", fw.Get("direction").String(), "has expected direction")
		assert.Equal(fmt.Sprintf("bastion@%s.iam.gserviceaccount.com", projectId), fw.Get("targetServiceAccounts").Array()[0].String(), "has correct target sa")
		assert.Equal("22", fw.Get("allowed").Array()[0].Map()["ports"].Array()[0].String(), "has expected allowed sports")
	})

	bpt.Test()
}
