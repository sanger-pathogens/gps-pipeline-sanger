# Extract the results from the output file of the PBP AMR predictor

# For all, replace null or space-only string with empty string

function GET_VALUE {
    < "$JSON_FILE" jq -r --arg target "$1" '.[$target]' \
        | sed 's/^null$//g;s/^\s+$//g'
}

pbp1a=$(GET_VALUE "pbp1a")
pbp2b=$(GET_VALUE "pbp2b")
pbp2x=$(GET_VALUE "pbp2x")
AMO_MIC=$(GET_VALUE "amxMic")
AMO=$(GET_VALUE "amx")
CFT_MIC=$(GET_VALUE "croMic")
CFT_NONMENINGITIS=$(GET_VALUE "croNonMeningitis")
CFT_MENINGITIS=$(GET_VALUE "croMeningitis")
TAX_MIC=$(GET_VALUE "ctxMic")
TAX_NONMENINGITIS=$(GET_VALUE "ctxNonMeningitis")
TAX_MENINGITIS=$(GET_VALUE "ctxMeningitis")
CFX_MIC=$(GET_VALUE "cxmMic")
CFX=$(GET_VALUE "cxm")
MER_MIC=$(GET_VALUE "memMic")
MER=$(GET_VALUE "mem")
PEN_MIC=$(GET_VALUE "penMic")
PEN_NONMENINGITIS=$(GET_VALUE "penNonMeningitis")
PEN_MENINGITIS=$(GET_VALUE "penMeningitis")

echo \"pbp1a\",\"pbp2b\",\"pbp2x\",\"AMO_MIC\",\"AMO_Res\",\"CFT_MIC\",\"CFT_Res\(Meningital\)\",\"CFT_Res\(Non-meningital\)\",\"TAX_MIC\",\"TAX_Res\(Meningital\)\",\"TAX_Res\(Non-meningital\)\",\"CFX_MIC\",\"CFX_Res\",\"MER_MIC\",\"MER_Res\",\"PEN_MIC\",\"PEN_Res\(Meningital\)\",\"PEN_Res\(Non-meningital\)\" > "$PBP_AMR_REPORT"
echo \""$pbp1a"\",\""$pbp2b"\",\""$pbp2x"\",\""$AMO_MIC"\",\""$AMO"\",\""$CFT_MIC"\",\""$CFT_MENINGITIS"\",\""$CFT_NONMENINGITIS"\",\""$TAX_MIC"\",\""$TAX_MENINGITIS"\",\""$TAX_NONMENINGITIS"\",\""$CFX_MIC"\",\""$CFX"\",\""$MER_MIC"\",\""$MER"\",\""$PEN_MIC"\",\""$PEN_MENINGITIS"\",\""$PEN_NONMENINGITIS"\" >> "$PBP_AMR_REPORT"
