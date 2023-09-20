package scepter

import data.utils.scepter.readable_user_assets
import data.utils.scepter.commandable_users_assets
import data.utils.scepter.manageable_users_assets

readable_assets := readable_user_assets[input.user_id]
commandable_assets := commandable_users_assets[input.user_id]
manageable_assets := manageable_users_assets[input.user_id]