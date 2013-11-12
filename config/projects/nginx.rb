
name "nginx"
maintainer "Brian Akins <brian@akins.org>"
homepage "http://openresty.org"

replaces        "nginx"
install_path    "/opt/nginx"
build_version   '1.4.3.3'
build_iteration 1

# creates required build directories
dependency "preparation"

# openresty dependencies/components
dependency "nginx"
dependency "luarocks"
dependency "lua-resty-riak"
dependency "luafilesystem"
dependency "luasec"
dependency "luasocket"

dependency "mmap_lowmem"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
