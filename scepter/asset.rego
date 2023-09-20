package scepter.asset


import future.keywords.in
import future.keywords.if
import data.utils.scepter.readable_user_assets

default allow := {
    "allow": false,
    "code": 403,
    "reason": "Forbidden"
}

allow := {
    "allow": true,
    "code": 200,
    "resources": readable_user_assets[input.user_id]
} {
    input.action == "search"
}

allow := {
    "allow": true,
    "code": 200,
} {
    input.action == "read"
    input.asset_id in readable_user_assets[input.user_id]
}

allow := {
    "allow": false,
    "code": 403,
    "reason": "User is missing read permissions for the requested satellite"
} {
    input.action == "read"
    not input.asset_id in readable_user_assets[input.user_id]
}