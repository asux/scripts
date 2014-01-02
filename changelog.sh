#!/bin/sh
since_commit=$1
[ -z ${since_commit} ] && since_commit="HEAD^1"
until_commit=$2
[ -z ${until_commit} ] && until_commit="HEAD"
git --no-pager log --no-color --pretty=format:'* %s [%an]' --abbrev-commit --no-merges ${since_commit}..${until_commit}
