#!/usr/bin/env nextflow
nextflow.enable.dsl=2

//---------------------------------------------------------------
// Param Checking 
//---------------------------------------------------------------

if(params.seqFile) {
  seqs = Channel.fromPath( params.seqFile ).splitFasta( by:params.fastaSubsetSize, file:true  )
}
else {
  throw new Exception("Missing params.seqFile")
}

//--------------------------------------------------------------------------
// Includes
//--------------------------------------------------------------------------

include { peripheralToCore } from './modules/orthoFinderPeripheralToCore.nf'

//--------------------------------------------------------------------------
// Main Workflow
//--------------------------------------------------------------------------

workflow {
  
    peripheralToCore(seqs)
   
}

