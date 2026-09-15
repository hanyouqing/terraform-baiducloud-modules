# BaiduCloud CI/CD Module

Identity + optional CFC automation for external CI (GitHub Actions / GitLab / Jenkins).

| Layer | In Terraform? | This module |
|-------|---------------|-------------|
| Deploy IAM user + access key | Yes | Default |
| Break-glass user | Yes | Optional |
| CFC scheduled / event jobs | Yes | Optional via `cfc_*` |
| 云效 / CodeHub / CIC pipelines | No | Use external CI + keys |

See `examples/basic` and `examples/complete`.
