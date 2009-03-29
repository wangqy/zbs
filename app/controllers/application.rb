# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  before_filter :set_menu
  before_filter :must_login

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9b790818f0cc793191f042e27b5ac4ce'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  #workflow definition
  @@pdef = OpenWFE.process_definition :name => 'dispatch_event' do
    sequence do
      logit
      #转办,自己受理,直接办结
      turn
      finish :if => "${f.handle} == 3"
    end
  end

  ruote_engine.register_participant :logit do |workitem|
    puts "logit"
  end

  ruote_engine.register_participant :receive do |workitem|
    puts "receive #{workitem.user_login}"
    OpenWFE::Extras::ArParticipant.new(:user_login)
  end

  ruote_engine.register_participant :turn, OpenWFE::Extras::ArParticipant do
    puts "turn to #{workitem.user_login}"
  end

  ruote_engine.register_participant :finish do |workitem|
    puts "finish event #{workitem.event_id}"
  end
                                                                                                                                                             
  #Creates an HistoryEntry record
  def history_log (event, options={})
    source = options.delete(:source) || current_user.login
    OpenWFE::Extras::HistoryEntry.log!(source, event, options)
  end
                  
  

  def must_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def set_menu
    @menu = controller_name
  end

end
