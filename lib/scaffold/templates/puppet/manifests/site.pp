# Site Manifest

Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin" }

File { 
  ignore => ['.svn', '.git', 'CVS', '*~' ],  
}

import "nodes/*.pp"

