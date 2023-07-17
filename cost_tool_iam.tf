resource "aws_iam_role" "cost_tool" {
  provider           = aws.cluster
  name               = var.cost_tool_iam_role
  description        = "Role used by cost tooling service principal"
  assume_role_policy = data.aws_iam_policy_document.cost-tool-assume-role-policy.json

  tags = merge(var.common_audit_tags, { Name : var.cost_tool_iam_role })
}

resource "aws_iam_policy" "cost-tool-policy" {
  provider    = aws.cluster
  name        = "cost_tool_policy"
  description = "Allows cost tooling to query Athena for CUR data"
  policy      = data.aws_iam_policy_document.cost-tool-role-policy.json
}

resource "aws_iam_role_policy_attachment" "cost-tool-role-attach" {
  provider   = aws.cluster
  role       = aws_iam_role.cost_tool.name
  policy_arn = aws_iam_policy.cost-tool-policy.arn
}
