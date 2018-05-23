# # encoding: utf-8

# Inspec test for recipe mongoDB::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end

# Check if MongoDB Package is Installed
describe package('mongodb-org') do
  it { should be_installed }
end

# Check if MongoDB is running
describe service('mongod') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# Check if MongoDB standard port is listening
describe port(27017) do
  it { should be_listening }
end

# Check if restart enable for mongod - check chkconfig on was set
describe command('systemctl list-unit-files | grep mongod') do
  its('stdout') { should match /mongod.service .* enabled/ }
end
