# Run SeroBA to serotype samples

seroba runSerotyping "${SEROBA_DB}" "$READ1" "$READ2" "$SAMPLE_ID" && SEROTYPE=$(awk -F',' 'NR==2 { print $3 }' "${SAMPLE_ID}/pred.csv")

echo \"Serotype\" > "$SEROTYPE_REPORT"
echo \""$SEROTYPE"\" >> "$SEROTYPE_REPORT"
