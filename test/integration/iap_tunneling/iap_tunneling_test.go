package iap_tunneling

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestIapTunneling(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)
		
		projectId := bpt.GetStringOutput("project_id")
		instance := bpt.GetStringOutput("instance")
		zone := bpt.GetStringOutput("zone")

		op := gcloud.Run(t,"")
		assert.Contains(op.Get("result").String(), randomFileString, "contains random string")
	})

	bpt.Test()
}