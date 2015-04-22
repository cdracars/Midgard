#
# Cookbook Name:: mgrd-iptables-ng
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

iptables_ng_chain 'INPUT' do
  policy 'DROP [0:0]'
  table 'filter'
end

iptables_ng_chain 'FORWARD' do
  policy 'ACCEPT [0:0]'
  table 'filter'
end

iptables_ng_chain 'OUTPUT' do
  policy 'ACCEPT [0:0]'
  table 'filter'
end

iptables_ng_chain 'fail2ban-ssh' do
  policy 'ACCEPT [0:0]'
  table 'filter'
end

iptables_ng_chain 'PREROUTING' do
  policy 'ACCEPT [0:0]'
  table 'nat'
end

iptables_ng_chain 'INPUT' do
  policy 'ACCEPT [0:0]'
  table 'nat'
end

iptables_ng_chain 'OUTPUT' do
  policy 'ACCEPT [0:0]'
  table 'nat'
end

iptables_ng_chain 'POSTROUTING' do
  policy 'ACCEPT [0:0]'
  table 'nat'
end

iptables_ng_rule 'input' do
  chain 'INPUT'
  rule ['-m state --state RELATED,ESTABLISHED -j ACCEPT',
  '-i eth0 -p tcp -m state --state NEW -m multiport --dports 20,21,22,80,443,40000:40010 -j ACCEPT',
  '-i eth1 -p tcp -m state --state NEW -m multiport --dports 22,80,443 -j ACCEPT',
  '-i eth1 -p all -j ACCEPT',
  '-i lo -j ACCEPT']
  ip_version 4
end

iptables_ng_rule 'forward' do
  chain 'FORWARD'
  rule ['-i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT',
  '-i eth1 -o eth0 -j ACCEPT']
  ip_version 4
end

iptables_ng_rule 'POSTROUTING' do
  chain 'POSTROUTING'
  table 'nat'
  rule '-o eth0 -j MASQUERADE'
  ip_version 4
end
