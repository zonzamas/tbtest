# Development libraries mix
class devtools {
  $devpackage_list = ['httpd-devel','openssl-devel','zlib-devel',
                      'gcc','gcc-c++','libcurl-devel','expat-devel',
                      'gettext-devel','patch','readline',
                      'readline-devel','zlib','libyaml-devel',
                      'libffi-devel','make',
                      'bzip2','sqlite-devel']
  
  package{$devpackage_list:
    ensure => present
  }
}
