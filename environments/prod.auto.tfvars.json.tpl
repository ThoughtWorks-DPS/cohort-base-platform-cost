{
    "assume_role": "DpsPlatformKubecostRole",
    "account_id": "{{ op://empc-lab/cohort-base-aws-prod/aws-account-id }}",
    "cluster_region": "us-east-1",
    "cur_report_name":"cohortbaseplatformprodcur",
    "cur_bucket_name":"{{ op://empc-lab/cohort-base-aws-prod/aws-account-id }}-cohort-base-cur",
    "cur_bucket_key_alias":"{{ op://empc-lab/cohort-base-aws-prod/aws-account-id }}-cohort-base-cur",
    "cur_region":"us-east-1",
    "athena_bucket_name":"aws-athena-query-results-{{ op://empc-lab/cohort-base-aws-prod/aws-account-id }}-cohort-base-cur",
    "athena_bucket_key_alias":"aws-athena-query-results-{{ op://empc-lab/cohort-base-aws-prod/aws-account-id }}-cohort-base-cur",
    "athena_workgroup_name":"cohortbaseplatform_prod_cost",
    "cluster_name":"prod-us-east-1",
    "cost_tool_service_account":"cost-tooling",
    "cost_tool_iam_role":"cost_tool_role",
    "common_audit_tags": {
        "CreatedOn": "2023-06-17",
        "CreatedBy": "dps-labs",
        "Project": "cohortbaseplatform",
        "Support": "dpslabs@thoughtworks.com",
        "Capability": "cohort-base-platform",
        "Pipeline": "cohort-base-platform-cost",
        "Environment": "prod"
    }
}
