require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe package('sinatra') do
  it { should be_installed.by('gem') }
end

describe package('unicorn') do
  it { should be_installed.by('gem') }
end

describe file('/opt/sinatra/pids/unicorn.pid') do
  it { should be_file }
  it { should be_readable }
  it { should_not be_writable.by('group') }
end

describe file('/var/temp/unicorn.sock') do
  it { should be_socket }
  it { should be_readable }
  it { should be_writable }
end
