#!/usr/bin/env bash

set -euo pipefail
perl /usr/bin/assignGroupsForPeripherals.pl --result $sortedResults --output groups.txt
