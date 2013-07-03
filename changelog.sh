#!/bin/sh
since=$1
[ -z ${since} ] && since="HEAD^1"
until=$2
[ -z ${until} ] && until="HEAD"
git  --no-pager log --no-color --pretty=format:'  * %s [%an]' --abbrev-commit --no-merges ${since}..${until}
