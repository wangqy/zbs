module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/i
      root_path
    when /the new log page/
      new_log_path

    when /the new notice page/
      new_notice_path

    
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World do |world|
  world.extend NavigationHelpers
  world
end
