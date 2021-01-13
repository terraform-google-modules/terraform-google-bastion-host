# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

GROUPNAME = 'bastion-mig'
REGION    = 'us-west1'

project_id = attribute('project_id')

control "Bastion Group" do
  title "Simple Configuration"
  describe "Instance configuration" do
    subject { command("gcloud --project=#{project_id} compute instance-groups list-instances #{GROUPNAME} --format=json --region #{REGION}") }
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }
    let!(:data) { JSON.parse(subject.stdout) if subject.exit_status == 0 }

    it "should be running" do
      data.each do |i|
        expect(i['status']).to eq('RUNNING')
      end
    end

    2.times do |i|
      context "with instance #{i}" do
        let!(:instance) do
          inst = data[i]['instance']
          JSON.parse(`gcloud compute instances describe #{inst} --format json`)
        end

        it "should have correct OS Login config" do
          entry = instance['metadata']['items'].find { |j| j['key'] == "enable-oslogin" }
          expect(entry['value']).to eq('TRUE')
        end

        it "should have Shielded VM enabled" do
          %w(enableIntegrityMonitoring enableSecureBoot enableVtpm).each do |j|
            expect(instance['shieldedInstanceConfig'][j]).to eq(true)
          end
        end
      end
    end
  end

  describe "SSH Firewall Rule" do
    subject { command("gcloud --project #{project_id} compute firewall-rules describe allow-ssh-from-iap-to-tunnel --format json") }
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }
    let!(:data) { JSON.parse(subject.stdout) if subject.exit_status == 0 }

    it "should allow SSH ingress from IAP" do
      expect(data['sourceRanges'][0]).to eq('35.235.240.0/20')
      expect(data['direction']).to eq('INGRESS')
      expect(data['targetServiceAccounts'][0]).to match("bastion@#{project_id}.iam.gserviceaccount.com")
      expect(data['allowed'][0]['ports'][0]).to eq("22")
    end
  end

end
