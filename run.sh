#!/bin/bash
# `git config -l` prints section and key names lowercased, pyinfra's git.config looks up
# the key as given: "camelCase key" reports a change on every run.
# Tested with
set -euo pipefail

export PS4="\n----------------[ "

# cleanup
cd "$(dirname "$0")"
rm -rf repo

set -x
pyinfra -y @local deploy.py
pyinfra -y @local deploy.py # camelCase key changes again

git -C repo config --local -l | grep hookspath
