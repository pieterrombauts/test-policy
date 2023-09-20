package utils.scepter

import data.utils.siam.user_roles

# Utility to fetch current readable assets based on user roles
readable_user_assets := { user_id: permissible_assets |
    user_id := data.users[_]._id
    user_account_roles := user_roles[user_id]
    permissible_assets := [ asset |
       some account_id
       role := user_account_roles[account_id][_]
       perm := data.permissions[_]
       perm.account_id == account_id
       perm.role == role
       perm.read_access == true
       asset := perm.asset_id
   ]
}

commandable_user_assets := { user_id: permissible_assets |
    user_id := data.users[_]._id
    user_account_roles := user_roles[user_id]
    permissible_assets := [ asset |
       some account_id
       role := user_account_roles[account_id][_]
       perm := data.permissions[_]
       perm.account_id == account_id
       perm.role == role
       perm.command_access == true
       asset := perm.asset_id
   ]
}

manageable_user_assets := { user_id: permissible_assets |
    user_id := data.users[_]._id
    user_account_roles := user_roles[user_id]
    permissible_assets := [ asset |
       some account_id
       role := user_account_roles[account_id][_]
       perm := data.permissions[_]
       perm.account_id == account_id
       perm.role == role
       perm.manage_access == true
       asset := perm.asset_id
   ]
}

# Helper rule to provide asset_ids that are publicly visible
publicly_visible_assets[assetId] {
    asset := data.assets[_]
    asset.publicly_visible == true
    assetId := asset._id
}