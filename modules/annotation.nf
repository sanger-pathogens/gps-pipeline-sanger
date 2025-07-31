// Return Bakta database path, download and create database if necessary
process GET_BAKTA_DB {
    label 'bash_container'
    label 'farm_low'
    label 'farm_scratchless'
    label 'farm_slow'

    input: 
    val db_remote
    path db

    output:
    path bakta_db, emit: path

    script:
    bakta_db="${db}/bakta"
    json='done_bakta.json'
    checksum='checksum.md5'
    """
    DB_REMOTE="$db_remote"
    DB_LOCAL="$bakta_db"
    JSON_FILE="$json"
    CHECKSUM_FILE='$checksum'

    source check-download_bakta_db.sh
    """
}

// Run Bakta to get annotation
// Publish the annotation to ${params.output}/annotations directory based on ${params.file_publish}
// TO-DO