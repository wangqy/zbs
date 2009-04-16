# set route path for event
class ActionController::Routing::RouteSet::Mapper

  def event_resources (*controller_names)
    controller_names.each do |controller_name|
      controller_name = controller_name.to_s
      #
      # paths and URLs

      plural = controller_name
      singular = plural.singularize

      type = singular.capitalize

      # GET
      #
      named_route(
        controller_name,
        controller_name,
        :controller => "events",
        :action => 'index',
        :type => type,
        :conditions => { :method => :get })
        
      named_route(
        singular,
        "#{controller_name}/:id",
        :controller => "events",
        :action => 'show',
        :type => type,
        :conditions => { :method => :get },
        :requirements => {:id => /\d+/})
        
      named_route(
        "new_#{singular}",
        "#{controller_name}/new",
        :controller => "events",
        :action => 'new',
        :type => type,
        :conditions => { :method => :get })

      named_route(
        "edit_#{singular}",
        "#{controller_name}/:id/edit",
        :controller => "events",
        :action => 'edit',
        :type => type,
        :conditions => { :method => :get })

      # POST
      connect(
        controller_name,
        :controller => "events",
        :action => 'create',
        :type => type,
        :conditions => { :method => :post })

      # PUT
      #
      connect(
        "#{controller_name}/:id",
        :controller => "events",
        :action => 'update',
        :type => type,
        :conditions => { :method => :put })

      # DELETE
      #
      connect(
        "#{controller_name}/:id",
        :controller => "events",
        :action => 'destroy',
        :type => type,
        :conditions => { :method => :delete })

    end
  end
end
