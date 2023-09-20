package scepter.asset


import future.keywords.in
import future.keywords.if
import data.utils.scepter.readable_user_assets

default decision := {
    "permit": false,
    "code": 403,
    "reason": "Forbidden",
}

decision := {
    "permit": true,
    "code": 200,
    "resources": readable_user_assets[input.user_id]
} if {
    print("testing search")
    input.action == "search"
}

decision := {
    "permit": true,
    "code": 200,
    "resources": readable_user_assets[input.user_id]
} if {
    print("testing read")
    input.action == "read"
    input.asset_id in readable_user_assets[input.user_id]
}

decision := {
    "permit": false,
    "code": 403,
    "reason": "User does not have read permission on this asset.",
} if {
    print("testing fail read")
    input.action == "read"
    not input.asset_id in readable_user_assets[input.user_id]
}