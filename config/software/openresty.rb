name "openresty"
version "1.2.7-6"

dependency "geoip"
dependency "openssl"
dependency "libxml2"
dependency "pcre"
dependency "gd"

source url: "http://openresty.org/download/ngx_openresty-1.2.7.6.tar.gz", md5: "bd1e49af52a050415ea3e3c56be16f8d"

relative_path "ngx_openresty-1.2.7.6"

env = {
  "LDFLAGS" => " -pie -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => " -fPIC -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}",
           "--with-luajit",
           "--sbin-path=#{install_dir}/sbin/nginx",
           "--conf-path=#{install_dir}/etc/nginx.conf",
           "--error-log-path=#{install_dir}/log/nginx/error.log",
           "--http-client-body-temp-path=#{install_dir}/lib/nginx/body",
           "--http-fastcgi-temp-path=#{install_dir}/lib/nginx/fastcgi",
           "--http-log-path=#{install_dir}/log/nginx/access.log",
           "--http-proxy-temp-path=#{install_dir}/lib/nginx/proxy",
           "--http-scgi-temp-path=#{install_dir}/lib/nginx/scgi",
           "--http-uwsgi-temp-path=#{install_dir}/lib/nginx/uwsgi",
           "--lock-path=#{install_dir}/lock/nginx.lock",
           "--pid-path=#{install_dir}/run/nginx.pid",
           "--with-http_dav_module",
           "--with-http_flv_module",
           "--with-http_geoip_module",
           "--with-http_gzip_static_module",
           "--with-http_image_filter_module",
           "--with-http_realip_module",
           "--with-http_stub_status_module",
           "--with-http_ssl_module",
           "--with-http_sub_module",
           "--with-http_xslt_module",
           "--with-ipv6",
           "--with-sha1=#{install_dir}/embedded/include/openssl",
           "--with-md5=#{install_dir}/embedded/include/openssl",
           "--with-mail",
           "--with-mail_ssl_module",
           "--with-http_stub_status_module",
           "--with-http_secure_link_module",
           "--with-http_sub_module",
           "--with-luajit-xcflags=' -fPIC '",
           "--with-pcre",
           "--with-cc-opt='-fPIC -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include'",
           "--with-ld-opt='-pie -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include'"
          ].join(" "), :env => env
  
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
