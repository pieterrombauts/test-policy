package utils.siam

# Generate constant-time lookup object for user accounts and roles
user_roles := { user_id: account_roles |
    user_id := data.users[_]._id
    account_roles := user_id
#    membership := data.memberships[_]
#    membership.user_id == user_id
#    account_roles := { account_id: roles |
#        account_id := membership.account_id
#        roles := [ role |
#            m := data.memberships[_]
#            m.user_id == user_id
#            m.account_id == account_id
#            role := m.role
#        ]
#    }
}