# Return PopPUNK database name
# Check if database was obtained from the specific link.
# Check if all files exist and data integrity is not compromised
# If not: remove all sub-directories, download, and unzip to database directory, also save metadata to JSON

DB_NAME=$(basename "$DB_REMOTE" .tar.gz)
DB_PATH=${DB_LOCAL}/${DB_NAME}

if  [ ! -f "${DB_LOCAL}/${JSON_FILE}" ] || \
    [ ! "$DB_REMOTE" == "$(jq -r .url "${DB_LOCAL}/${JSON_FILE}")"  ] || \
    [ ! -f "${DB_LOCAL}/${CHECKSUM_FILE}" ] || \
    ! ( cd "${DB_LOCAL}" && md5sum -c "${CHECKSUM_FILE}" ) ; then

    rm -rf "${DB_LOCAL}"

    wget "$DB_REMOTE" -O poppunk_db.tar.gz
    mkdir -p "${DB_LOCAL}"
    tar -xzf poppunk_db.tar.gz -C "$DB_LOCAL"
    rm poppunk_db.tar.gz

    ( cd "${DB_LOCAL}" && find . -type f -not -name "${CHECKSUM_FILE}" -exec md5sum "{}" + ) > "${DB_LOCAL}/${CHECKSUM_FILE}"

    jq -n \
        --arg url "$DB_REMOTE" \
        --arg save_time "$(date +"%Y-%m-%d %H:%M:%S %Z")" \
        --arg db_version "$DB_NAME" \
        '{"url" : $url, "save_time": $save_time, "db_version", $db_version}' > "${DB_LOCAL}/${JSON_FILE}"

fi
