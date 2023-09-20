package scepter.asset


import future.keywords.in
import data.scepter.readable_assets

default decision := {
    "permit": false,
    "code": 403,
    "reason": "Forbidden",
}

decision := {
    "permit": true,
    "code": 200,
    "resources": readable_assets
} {
    input.action == "search"
}

decision := {
    "permit": true,
    "code": 200,
    "resources": readable_assets
} {
    input.action == "read"
    input.asset_id in readable_assets
}

decision := {
    "permit": false,
    "code": 403,
    "reason": "User does not have read permission on this asset.",
} {
    input.action == "read"
    not input.asset_id in readable_assets
}