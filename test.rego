package scepter.satellite

default decision = {
    "permit": false,
    "reason": "Forbidden",
    "resources": set()
}

decision = {
    "permit": permit_decision,
    "reason": reason_msg,
    "resources": accessible_assets
}

permit_decision = true { asset_in_accessible_assets } 
permit_decision = false { not asset_in_accessible_assets } 

# Rule to check if the assetId exists in accessible_assets
asset_in_accessible_assets {
    some_asset_in_set := accessible_assets[_]
    some_asset_in_set == input.assetId
}

# Set reason message based on permit_decision
reason_msg = "" { asset_in_accessible_assets }
reason_msg = "User does not have permission to view this asset" { not asset_in_accessible_assets }

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

# Main rule to allow access if assetId exists either in user_readable_asset_ids 
# or in publicly_visible_asset_ids
permit_decision = true {
    input.assetId = accessible_assets[_]
}
