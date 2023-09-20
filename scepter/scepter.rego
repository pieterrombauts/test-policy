package scepter

import data.utils.scepter.readable_user_assets
import data.utils.scepter.commandable_user_assets
import data.utils.scepter.manageable_user_assets

readable_assets := readable_user_assets[input.user_id]
commandable_assets := commandable_user_assets[input.user_id]
manageable_assets := manageable_user_assets[input.user_id]