

         -- Approach 1. Using - BIT_AND / BIT_OR -- 
SELECT 
    BIT_AND(permissions::bit(32))::int common_perms,
    BIT_OR(permissions::bit(32))::int any_perms
FROM user_permissions;
