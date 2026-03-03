

         -- The Best Approach. Using - ROUND / NULLIF / Subquery --  
SELECT 
	ROUND(
      	COALESCE(
				(SELECT COUNT(DISTINCT (accepter_id, requester_id)) FROM RequestAccepted )::numeric 
  	  			/ NULLIF((SELECT COUNT(DISTINCT (sender_id, send_to_id)) FROM FriendRequest), 0)
          	, 0)
  	, 2) accept_rate
