# Copyright 2019 Google LLC
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

project_id = attribute('project_id')

control "Bastion Instance" do
  title "Simple Configuration"

  describe command("gcloud --project=#{project_id} compute instances list --format=json --filter='name~bastion*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "number of instances" do
      it "should be 1" do
        expect(data.length).to eq(1)
      end
    end

    describe "instance" do
      let(:instance) do
        data.find { |i| i['name'] == "bastion-vm" }
      end

      it "should be in zone us-west1-a}" do
        expect(instance['zone']).to match(/.*us-west1-a$/)
      end
    end
  end
end
