class Msg < ActiveRecord::Base
  establish_connection :sms
  set_table_name :tbl_SMSendTask
  set_primary_key :ID
end
