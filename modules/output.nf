process GENERATE_SAMPLE_REPORT {
    label 'bash_container'
    label 'farm_low'

    tag "$sample_id"

    input:
    tuple val(sample_id), path("${sample_id}_process_report_?.csv")

    output:
    path sample_report, emit: report

    script:
    sample_report="${sample_id}_report.csv"
    """
    SAMPLE_ID="$sample_id"
    SAMPLE_REPORT="$sample_report"

    source generate_sample_report.sh
    """
}

process GENERATE_OVERALL_REPORT {
    label 'python_container'
    label 'farm_low'

    publishDir "${output}", mode: "copy"

    input:
    path '*'
    path ariba_metadata
    path resistance_to_mic
    val output

    output:
    path "$overall_report", emit: report

    script:
    input_pattern='*_report.csv'
    overall_report='results.csv'
    """
    generate_overall_report.py '$input_pattern' $ariba_metadata $resistance_to_mic $overall_report
    """
}
