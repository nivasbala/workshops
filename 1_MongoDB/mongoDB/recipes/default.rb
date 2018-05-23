#
# Cookbook:: mongoDB
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#

# Set Apt (Yum in this case) to run periodically
apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

# Run Apt (Yum Update ) now
apt_update 'update'

template_repofile = ''
# Get Architecture and set the repo accordingly
execute 'Get_Arch_type' do
  # Get Architecture of the system 32 bit or 64 bit
  arch = command 'lscpu | grep -i architecture'

  template_repofile = if arch == 'x86_64'
                        'mongodb-org.repo-64.erb'
                      else
                        'mongodb-org.repo-32.erb'
                      end
end

# Create the MongoDB Repo file from template
template '/etc/yum.repos.d/mongodb-org.3.4.repo' do
  source 'mongodb-org.repo-64.erb'
  # source #{templateRepoFile}
  action:create
end

# Install mongodb-org component
package 'mongodb-org' do
  action:install
end

# Start the MongoDB, Stop it and Restart it
service 'mongod' do
  action [:start, :stop, :restart]
end

# Make sure MongoDB starts after a reboot
execute 'restart_enable_mongodb' do
  command 'chkconfig mongod on'
end
