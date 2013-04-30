
name "openresty"
maintainer "Brian Akins <brian@akins.org>"
homepage "http://openresty.org"

replaces        "openresty"
install_path    "/opt/openresty"
#build_version   Omnibus::BuildVersion.new.semver
build_version   '1.2.7'
build_iteration 1

# creates required build directories
dependency "preparation"

# openresty dependencies/components
dependency "openresty"
dependency "luarocks"
dependency "lua-resty-riak"
dependency "mmap_lowmem"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
