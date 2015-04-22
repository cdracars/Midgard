#
# Cookbook Name:: mgrd-sysctl
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

sysctl_param 'net.ipv4.ip_forward' do
  value 1
end
