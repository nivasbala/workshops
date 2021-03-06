#
# Cookbook:: Tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#############
# Variables #
#############
tomcat_version = node['tomcat']['version']
tomcat_binary = "apache-tomcat-#{tomcat_version}.tar.gz"
tomcat_path = '/opt/tomcat'
java_version = node['java']['version']

# The Temporary File location for the system (defined the system)
tmp_file_path = Chef::Config[:file_cache_path]

# local file name to put the tar bar
local_file_name = tmp_file_path.to_s + "\/" + tomcat_binary.to_s

################
# Recipe Start #
################

# Set Apt (Yum in this case) to run periodically
apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

# Run Apt (Yum Update ) now
apt_update 'update' do
  action:update
end

# Install Java
package "java-#{java_version}-openjdk-devel" do
  action:install
end

# Create Tomcat group and user
group 'tomcat' do
  action:create
end

user 'tomcat' do
  group 'tomcat'
  system true
  home tomcat_path
  shell '/bin/nologin'
  action:create
end

# Download the tomcat tarball to tmp directory defined by the system
remote_file local_file_name do
  source "https://archive.apache.org/dist/tomcat/tomcat-8/v#{tomcat_version}/bin/#{tomcat_binary}"
  action:create
  notifies:run, 'script[extract_tomcat]', :immediately 
end

# Extract the files from the tarball to /opt/tomcat
script 'extract_tomcat' do
  interpreter 'bash'
  cwd tmp_file_path.to_s
  code <<-EOH
    mkdir -p #{tomcat_path}
    tar xzf 'apache-tomcat-#{tomcat_version}.tar.gz' -C #{tomcat_path} --strip-components=1
    EOH
    action:nothing
end

# Set Group for tomcat directory
execute 'tomcat-dir_set_group' do
  command "chgrp -R tomcat #{tomcat_path}"
  action:run
  notifies:run, 'script[set_tomcat_dir_permission]', :immediately
end

# Set Ownership group and user for /opt/tomcat to tomcat
script 'set_tomcat_dir_permission' do
  interpreter 'bash'
  cwd tomcat_path
  code <<-EOH
    # chmod -R 755
    chmod -R g+r conf/
    chmod -R g+x conf/
    chown -R tomcat webapps work temp logs
    EOH
  action:nothing
end

# Create tomcat.service file from template
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
  action:create
end

# Restart systemd
execute 'systemd_restart' do
  command 'systemctl daemon-reload'
  action:run
end

# Start tomcat service and enable
service 'tomcat' do
  action [:start, :enable]
end
