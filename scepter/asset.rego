package scepter.asset


import future.keywords.in
import future.keywords.if
import data.utils.scepter.readable_user_assets

default allow := "deny"

allow := "search allow" {
    input.action == "search"
}

allow := "read allow" {
    input.action == "read"
    input.asset_id in readable_user_assets[input.user_id]
}

allow := "read deny" {
    input.action == "read"
    not input.asset_id in readable_user_assets[input.user_id]
}