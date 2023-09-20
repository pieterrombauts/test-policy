package utils.scepter

# Constant-time lookup for permissible assets based on user id
user_assets := { user_id: permissible_assets |
    user_id := data.users[_]._id
    user_account_roles := user_roles[input.user_id]
    permissible_assets := { permission_level: assets |
        permission_level := ["read_access", "command_access", "manage_access"][_]

        assets := [ asset |
            some account_id
            role := user_account_roles[account_id][_]

            perm := data.permissions[_]
            perm.account_id == account_id
            perm.role == role
            perm[permission_level] == true

            asset := perm.asset_id
        ]
    }
}