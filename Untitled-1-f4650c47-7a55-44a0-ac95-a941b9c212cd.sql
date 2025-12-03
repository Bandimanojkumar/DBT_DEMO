select 
*
from {{ source('customer', 'employees') }}