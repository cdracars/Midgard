#
# Cookbook Name:: mgrd-pound
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package 'pound'

key_path = '/etc/ssl/private/midgard.pem'

unless File.file? key_path
  execute 'create pem file' do
    cwd '/etc/ssl/private'
    user 'root'
    command "openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
             -subj '/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com'\
             -keyout midgard.pem  -out midgard.pem"
  end
end

cookbook_file '/etc/pound/pound.cfg' do
  source 'pound.cfg'
  mode '0644'
  action :create
end

cookbook_file '/etc/default/pound' do
  source 'etc-default-pound'
  mode '0644'
  action :create_if_missing
end

# take new config
service 'pound' do
  action :restart
end
