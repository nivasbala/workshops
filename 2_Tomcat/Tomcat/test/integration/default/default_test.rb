# # encoding: utf-8

# Inspec test for recipe Tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

#####################
# InSpec Test Start #
#####################

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

# Check if Java is installed
describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

# Check if tomcat group is created
describe group('tomcat') do
  it { should exist }
end

# Check if tomcat user is created
describe user('tomcat') do
  it { should exist }
end

# Check if /opt/tomcat was created and group/permissions set
describe directory('/opt/tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('mode') { should cmp '0755' }
end

# Check if /opt/tomcat/conf has same group/permissions set
describe directory('/opt/tomcat/conf') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('mode') { should cmp '0750' }
end

# Check if tomcat.service file was created
describe file('/etc/systemd/system/tomcat.service') do
  it { should exist }
end

# Check if tomcat service is running and enabled
describe service('tomcat') do
  it { should be_running }
  it { should be_enabled }
end

# Check if the webpage is accessible
describe command('curl http://localhost:8080') do
  its('stdout') { should match /.*Apache Software Foundation.  All Rights Reserved.*/ }
end
