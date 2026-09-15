locals {
  # Normalize group policy attachments: policy_keys (legacy) + explicit policy_attachments
  group_policy_attachments = {
    for pair in flatten([
      for gk, g in var.groups : concat(
        [
          for pk in g.policy_keys : {
            key         = "${gk}-${pk}"
            group_key   = gk
            policy_key  = pk
            policy_name = null
            policy_type = null
          }
        ],
        [
          for a in g.policy_attachments : {
            key         = "${gk}-${a.policy_key != null ? a.policy_key : a.policy_name}"
            group_key   = gk
            policy_key  = a.policy_key
            policy_name = a.policy_name
            policy_type = a.policy_type
          }
        ]
      )
    ]) : pair.key => pair
  }
}

resource "baiducloud_iam_user" "this" {
  for_each = var.users

  name          = each.value.name
  description   = each.value.description
  force_destroy = each.value.force_destroy
}

resource "baiducloud_iam_access_key" "this" {
  for_each = {
    for k, v in var.users : k => v
    if v.create_access_key
  }

  username    = baiducloud_iam_user.this[each.key].name
  pgp_key     = each.value.pgp_key
  secret_file = each.value.secret_file
}

resource "baiducloud_iam_policy" "this" {
  for_each = var.policies

  name        = each.value.name
  document    = each.value.document
  description = each.value.description
}

resource "baiducloud_iam_user_policy_attachment" "this" {
  for_each = var.user_policy_attachments

  user        = baiducloud_iam_user.this[each.value.user_key].name
  policy      = each.value.policy_key != null ? baiducloud_iam_policy.this[each.value.policy_key].name : each.value.policy_name
  policy_type = each.value.policy_type
}

resource "baiducloud_iam_group" "this" {
  for_each = var.groups

  name          = each.value.name
  description   = each.value.description
  force_destroy = each.value.force_destroy
}

resource "baiducloud_iam_group_membership" "this" {
  for_each = {
    for k, g in var.groups : k => g
    if length(g.user_keys) > 0
  }

  group = baiducloud_iam_group.this[each.key].name
  users = [for uk in each.value.user_keys : baiducloud_iam_user.this[uk].name]
}

resource "baiducloud_iam_group_policy_attachment" "this" {
  for_each = local.group_policy_attachments

  group       = baiducloud_iam_group.this[each.value.group_key].name
  policy      = each.value.policy_key != null ? baiducloud_iam_policy.this[each.value.policy_key].name : each.value.policy_name
  policy_type = each.value.policy_type
}
