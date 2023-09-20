package scepter.asset


import future.keywords.in
import future.keywords.if
import data.utils.scepter.readable_user_assets

default allow := false

allow {
    print("testing search")
    input.action == "search"
}

allow {
    print("testing read")
    input.action == "read"
    input.asset_id in readable_user_assets[input.user_id]
}

allow {
    print("testing fail read")
    input.action == "read"
    not input.asset_id in readable_user_assets[input.user_id]
}