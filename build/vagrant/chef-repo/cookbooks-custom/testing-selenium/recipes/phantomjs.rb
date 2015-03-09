#
include_recipe "nodejs"

execute 'npm install -g phantomjs'

execute 'touch /phantomjsdriver.log'
execute 'chmod 666 /phantomjsdriver.log'

package 'libfontconfig1-dev'