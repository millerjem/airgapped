# IAM
resource "aws_iam_role" "ec2_ag_access_role" {
  name               = "ag-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "konvoy-ag-policy"
  policy      = "${file("policy.json")}"
}

resource "aws_iam_policy_attachment" "ag-attach" {
  name       = "ag-attachment"
  roles      = ["${aws_iam_role.ec2_ag_access_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "ag_profile" {
  name  = "ag_profile"
  role  = "${aws_iam_role.ec2_ag_access_role.name}"
}
