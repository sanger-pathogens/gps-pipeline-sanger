#!/usr/bin/env nextflow

// Import workflow modules
include { PIPELINE } from './workflows/pipeline'
include { INIT } from './workflows/init'
include { PRINT_VERSION; SAVE_INFO } from './workflows/info_and_version'

// Start message
Messages.startMessage(workflow.manifest.version, log)

// Validate parameters
Validate.validate(params, workflow, log)

// If Singularity is used as the container engine and not showing help message, do preflight check to prevent parallel pull issues
// Related issue: https://github.com/nextflow-io/nextflow/issues/1210
if (workflow.containerEngine == 'singularity' & !params.help) {
    Singularity.singularityPreflight(workflow.container, params.singularity_cachedir, log)
}

// Select workflow with PIPELINE as default
workflow {
    if (params.help) {
        Messages.helpMessage(log)
    } else if (params.init) {
        Messages.workflowSelectMessage('init', params, log)
        INIT()
    } else if (params.version) {
        Messages.workflowSelectMessage('version', params, log)
        PRINT_VERSION(params.resistance_to_mic, workflow.manifest.version)
    } else {
        Messages.workflowSelectMessage('pipeline', params, log)
        PIPELINE()
        SAVE_INFO(PIPELINE.out.databases_info, params.resistance_to_mic, workflow.manifest.version)
    }

    // End message
    workflow.onComplete = {
        if (params.help) {
            return
        } else if (params.init) {
            Messages.endMessage('init', params, workflow, log)
        } else if (params.version) {
            Messages.endMessage('version', params, workflow, log)
        } else {
            Messages.endMessage('pipeline', params, workflow, log)
        }
    }
}

