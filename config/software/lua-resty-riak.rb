name "lua-resty-riak"
default_version "0.2.1"

dependency "luarocks"
dependency "lua-pb"

source git: "https://github.com/bakins/lua-resty-riak.git"

build do
  command "#{install_dir}/embedded/luajit/bin/luarocks make"
end
