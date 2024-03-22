select USER_ID as user_guid
,FIRST_NAME
,LAST_NAME
,EMAIL
,PHONE_NUMBER
,CREATED_AT
,UPDATED_AT
,ADDRESS_ID
from {{ source('postgres','users') }}