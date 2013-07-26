#
# Cookbook Name:: apt-repos-cookbook
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "apt-s3-cookbook"

repo_name = node[:apt][:repo_name]
fqdn = node[:apt][:fqdn]
accesskey = node[:apt][:accesskey]
secretkey = node[:apt][:secretkey]


case node['platform_family']
when "debian"
  apt_repository repo_name do
    uri "s3://" + accesskey + ":" + secretkey + "@" + fqdn
    distribution node['lsb']['codename']
    components ["main"]
    action :add
  end
end

execute "update repos" do
  command "sudo apt-get update"
  cwd "/tmp"
  action :run
end
