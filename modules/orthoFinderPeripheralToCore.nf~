#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process createDatabase {
  container = 'rdemko2332/orthofinderperipheraltocore'

  input:
    path newdbfasta

  output:
    path 'newdb.dmnd'

  script:
    template 'createDatabase.bash'
}

process diamondSimilarity {
  container = 'rdemko2332/orthofinderperipheraltocore'

  input:
    path fasta
    path database
    val diamondArgs 

  output:
    path 'diamondSimilarity.out', emit: output_file

  script:
    template 'diamondSimilarity.bash'
}

process sortResults {
  container = 'rdemko2332/orthofinderperipheraltocore'

  input:
    path output
        
  output:
    path 'diamondSimilarity.out'

  script:
    """
    cat $output | sort -k 1 > diamondSimilarity.out
    """
}

process assignGroups {
  container = 'rdemko2332/orthofinderperipheraltocore'

  publishDir params.outputDir, mode: "copy"
  
  input:
    path sortedResults
        
  output:
    path 'groups.txt'

  script:
    template 'assignGroups.bash'
}

process makeResidualAndPeripheralFastas {
  container = 'rdemko2332/orthofinderperipheraltocore'

  publishDir params.outputDir, mode: "copy"
  
  input:
    path groups
    path seqFile
        
  output:
    path 'residuals.fasta'
    path 'peripherals.fasta'

  script:
    template 'makeResidualAndPeripheralFastas.bash'
}

workflow peripheralToCore {
  take:
    seqs

  main:
    database = createDatabase(params.databaseFasta)
    diamondSimilarityResults = diamondSimilarity(seqs, database, params.diamondArgs)
    similarityResults = diamondSimilarityResults.output_file | collectFile(name: 'similarity.out')
    sortedResults = sortResults(similarityResults)
    assignGroupsResults = assignGroups(sortedResults)
    makeResidualAndPeripheralFastas(assignGroupsResults, params.seqFile)
 
}