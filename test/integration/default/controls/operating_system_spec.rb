control "operating_system" do
  describe "the operating system" do
    subject do
      command("cat /etc/os-release").stdout
    end

    it "is Ubuntu" do
      is_expected.to match /Ubuntu/
    end
  end
end

describe os.name do
  it { should eq 'ubuntu' }
end

describe os.release do
	it { should eq '18.04' }
end
