package scepter.assets

default decision = {
    "permit": false,
    "code": 403,
    "reason": "Forbidden",
    "resources": set()
}

decision = {
    "permit": permit_decision,
    "code": decision_code,
    "reason": reason_msg,
    "resources": accessible_assets
}

decision_code = 200 { permit_decision == true }
decision_code = 403 { permit_decision == false }

permit_decision = true { asset_in_accessible_assets }
permit_decision = false { not asset_in_accessible_assets }

# Rule to check if the assetId exists in accessible_assets
asset_in_accessible_assets {
    some_asset_in_set := accessible_assets[_]
    some_asset_in_set == input.assetId
}

# Set reason message based on permit_decision
reason_msg = "" { permit_decision == true }
reason_msg = "User does not have permission to view this asset" { permit_decision == false }






# Helper rule to determine which accounts the user is a member of
user_account_roles := { accountId: roles | 
    mem := data.memberships[_]
    mem.user_id == input.userId
    accountId := mem.account_id
    roles := [ role | 
        m := data.memberships[_]
        m.user_id == input.userId
        m.account_id == accountId
        role := m.role
    ]
}





# Helper rule to provide asset_ids that a given userId can access based on permissions
user_readable_asset_ids[assetId] {
    perm := data.permissions[_]
    perm.user_uuid == input.userId
    perm.read_access == true
    assetId := perm.asset_id
}

# Helper rule to provide asset_ids that are publicly visible
publicly_visible_asset_ids[assetId] {
    asset := data.assets[_]
    asset.publicly_visible == true
    assetId := asset._id
}

# Helper rule to provide all assets accessible to a user (merged set of user_readable and publicly visible assets)
accessible_assets = output {
    user_assets := { a | a = user_readable_asset_ids[_]}
    pub_assets := { a | a = publicly_visible_asset_ids[_]}
    output := user_assets | pub_assets
}
