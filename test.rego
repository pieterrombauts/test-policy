package scepter.satellite

default allow = false

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
accessible_assets[assetId] {
    assetId = user_readable_asset_ids[_]
}

accessible_assets[assetId] {
    assetId = publicly_visible_asset_ids[_]
}

# Main rule to allow access if assetId exists either in user_readable_asset_ids 
# or in publicly_visible_asset_ids
allow {
    input.assetId = user_readable_asset_ids[_]
} else {
    input.assetId = publicly_visible_asset_ids[_]
}
