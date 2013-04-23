name "openresty"
version "1.2.7.6"

dependency "geoip"
dependency "openssl"
dependency "libxml2"
dependency "libxslt"
dependency "pcre"
dependency "gd"
dependency "ngx_http_gunzip_filter_module"
dependency "ngx_http_filter_cache"
dependency "nginx_upstream_check_module"
dependency "nginx_http_jsonp_module"
dependency "nginx-upload-module"
dependency "ngx_cache_purge"
dependency "nginx-statsd"

source url: "http://openresty.org/download/ngx_openresty-#{version}.tar.gz", md5: "bd1e49af52a050415ea3e3c56be16f8d"

relative_path "ngx_openresty-#{version}"

env = {
  "LDFLAGS" => " -pie -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => " -fPIC -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "patch -p1 < #{source_dir}/ngx_http_filter_cache/core.diff", cwd: "#{project_dir}/bundle/nginx-1.2.7"
  command "patch -p1 < #{source_dir}/nginx_upstream_check_module/check_1.2.6+.patch",  cwd: "#{project_dir}/bundle/nginx-1.2.7"
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-luajit",
           "--sbin-path=#{install_dir}/sbin/openresty",
           "--conf-path=#{install_dir}/etc/openresty.conf",
           "--error-log-path=#{install_dir}/log/openresty/error.log",
           "--http-client-body-temp-path=#{install_dir}//embedded/lib/openresty/body",
           "--http-fastcgi-temp-path=#{install_dir}/embedded/lib/openresty/fastcgi",
           "--http-log-path=#{install_dir}/log/openresty/access.log",
           "--http-proxy-temp-path=#{install_dir}/embedded/lib/openresty/proxy",
           "--http-scgi-temp-path=#{install_dir}/embedded/lib/openresty/scgi",
           "--http-uwsgi-temp-path=#{install_dir}/embedded/lib/openresty/uwsgi",
           "--lock-path=#{install_dir}/lock/openresty.lock",
           "--pid-path=#{install_dir}/run/openresty.pid",
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
           "--with-ld-opt='-pie -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -Wl,-rpath #{install_dir}/embedded/lib'",
           "--add-module=#{source_dir}/ngx_http_gunzip_filter_module",
           "--add-module=#{source_dir}/ngx_http_filter_cache",
           "--add-module=#{source_dir}/nginx_upstream_check_module",
           "--add-module=#{source_dir}/nginx_http_jsonp_module",
           "--add-module=#{source_dir}/nginx-upload-module",
           "--add-module=#{source_dir}/ngx_cache_purge",
           "--add-module=#{source_dir}/nginx-statsd"
          ].join(" "), :env => env
  
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
  command "rm /opt/openresty/sbin/openresty.old || true"
end
