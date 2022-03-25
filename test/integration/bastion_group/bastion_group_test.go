// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package bastion_group

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/stretchr/testify/assert"
)

func TestBastionGroup(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		ig := gcloud.Runf(t, "compute instance-groups list-instances bastion-mig --region us-west1 --project %s", projectId).Array()
		for _, instance := range ig {
			assert.Equal("RUNNING", instance.Get("status").String(), "is running")
			instanceData := gcloud.Runf(t, "compute instances describe %s --project %s", instance.Get("instance").String(), projectId)
			osLogin := utils.GetFirstMatchResult(t, instanceData.Get("metadata.items").Array(), "key", "enable-oslogin")
			assert.Equal("TRUE", osLogin.Get("value").String(), "os-login is enabled")
			for _, shieldedInstanceConfigValue := range instanceData.Get("shieldedInstanceConfig").Map() {
				assert.True(shieldedInstanceConfigValue.Bool(), "should have Shielded VM enabled")
			}
		}

		fw := gcloud.Runf(t, "compute firewall-rules describe allow-ssh-from-iap-to-bastion-group --project %s", projectId)
		assert.Equal("35.235.240.0/20", fw.Get("sourceRanges").Array()[0].String(), "has expected sourceRanges")
		assert.Equal("INGRESS", fw.Get("direction").String(), "has expected direction")
		assert.Equal(fmt.Sprintf("bastion-group@%s.iam.gserviceaccount.com", projectId), fw.Get("targetServiceAccounts").Array()[0].String(), "has correct target sa")
		assert.Equal("22", fw.Get("allowed").Array()[0].Map()["ports"].Array()[0].String(), "has expected allowed sports")
	})

	bpt.Test()
}
