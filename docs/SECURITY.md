# Security notes

- Never commit `.env.sh`, `*.tfvars`, or API keys.
- Prefer VPC-private RDS/SCS (`public_access = false`).
- Keep BOS buckets `acl = "private"` unless a public website is intentional.
- Restrict security group ingress to known CIDRs; avoid `0.0.0.0/0` on SSH.
- Use Terragrunt remote state in a private BOS bucket with least-privilege IAM.
