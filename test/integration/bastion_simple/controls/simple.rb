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

HOSTNAME = 'bastion-vm'
ZONE = 'us-west1-a'

project_id = attribute('project_id')

control "Bastion Instance" do
  title "Simple Configuration"
  describe "Instance configuration" do
    subject { command("gcloud --project=#{project_id} compute instances describe #{HOSTNAME} --format=json --zone #{ZONE}") }
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }
    let!(:data) { JSON.parse(subject.stdout) if subject.exit_status == 0 }

    it "should be running" do
      expect(data['status']).to eq('RUNNING')
    end

    it "should have correct OS Login config" do
      entry = data['metadata']['items'].find { |i| i['key'] == "enable-oslogin" }
      expect(entry['value']).to eq('TRUE')
    end

    it "should have Shielded VM enabled" do
      %w(enableIntegrityMonitoring enableSecureBoot enableVtpm).each do |i|
        expect(data['shieldedInstanceConfig'][i]).to eq(true)
      end
    end
  end

  describe "Instance Template" do
    subject { command("gcloud --project=#{project_id} compute instance-templates list --format=json") }
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }
    let!(:data) { JSON.parse(subject.stdout) if subject.exit_status == 0 }

    it "should include the right instance prefix" do
      template = data.select { |o| o["name"].start_with? "bastion-instance-template" }
      expect(template.any?).to eq(true)
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
