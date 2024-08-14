# Determine overall QC result based on File Validity, Read QC, Assembly QC, Mapping QC and Taxonomy QC
# In case File Validity is not PASS, save its value (i.e. description of the issue) to Overall QC
# In case of assembler failure, there will be no Assembly QC input, save ASSEMBLER FAILURE to Overall QC

assign_overall_qc() {
    if [[ "$FILE_VALIDITY" == "null" ]]; then
        OVERALL_QC="FILE VALIDATION FAILURE"
        return
    fi
    
    if [[ ! "$FILE_VALIDITY" == "PASS" ]]; then
        OVERALL_QC="$FILE_VALIDITY"
        return
    fi
    
    if [[ "$READ_QC" == "null" ]]; then
        OVERALL_QC="PREPROCESSOR FAILURE"
        return
    fi 
    
    if [[ "$READ_QC" == "FAIL" ]]; then
        OVERALL_QC="FAIL"
        return
    fi 

    if [[ "$ASSEMBLY_QC" == "null" ]]; then
        OVERALL_QC="ASSEMBLER FAILURE"
        return
    fi
    
    if [[ "$MAPPING_QC" == "null" ]]; then
        OVERALL_QC="MAPPER FAILURE"
        return
    fi

    if [[ "$TAXONOMY_QC" == "null" ]]; then
        OVERALL_QC="TAXONOMY CLASSIFIER FAILURE"
        return
    fi

    if [[ "$READ_QC" == "PASS" ]] && [[ "$ASSEMBLY_QC" == "PASS" ]] && [[ "$MAPPING_QC" == "PASS" ]] && [[ "$TAXONOMY_QC" == "PASS" ]]; then
        OVERALL_QC="PASS"
    else
        OVERALL_QC="FAIL"
    fi
}

assign_overall_qc

echo \"Overall_QC\" > "$OVERALL_QC_REPORT"
echo \""$OVERALL_QC"\" >> "$OVERALL_QC_REPORT"
