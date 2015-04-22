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
  bash 'create pem file' do
    user 'root'
    cwd '/etc/ssl/private'
    code <<-EOH
    cd /etc/ssl && openssl req -x509 -newkey rsa:1024 -keyout midgard.pem -out midgard.pem -days 365 -nodes
    EOH
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
