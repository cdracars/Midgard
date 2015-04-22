#
# Cookbook Name:: mgrd-pound
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package 'pound'

key_path = '/etc/ssl/private/midguard.pem'

unless File.file? key_path
  cookbook_file key_path do
    source 'midguard.pem'
    mode '0400'
  end

  cookbook_file '/etc/pound/pound.cfg' do
    source 'pound.cfg'
    mode '0644'
  end

  cookbook_file '/etc/default/pound' do
    source 'etc-default-pound'
    mode '0644'
  end

  # take new config
  service 'pound' do
    action :restart
  end
end
