#!/usr/bin/env bash

set -euo pipefail

perl /usr/bin/makeResidualAndPeripheralFastas.pl --groups $groups --seqFile $seqFile --residuals residuals.fasta --peripherals peripherals.fasta
