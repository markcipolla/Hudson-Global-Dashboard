HudsonDashboard.controllers :dashboard do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :respond_to => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index, :map => '(/)' do
    @builds_details = []

    Buildserver.all.each do |server|
      begin
        server_data = JSON.parse(Net::HTTP.get(URI.parse("#{URI.escape(server.address)}/api/json?depth=1")))
      rescue Exception => e
        server_data = nil
      end

      if server_data
        server_data["jobs"].each do |job|

          job.merge!("hudson_host" => "#{server.address}")

          # Build broken by
          if job['lastSuccessfulBuild'] && job['color'] == 'red'
            res = Net::HTTP.get(URI.parse("#{job['hudson_host']}/job/#{URI.escape(job['name'])}/#{job['lastSuccessfulBuild']["number"] + 1}/changes"))
            build_broken_by_username = res.to_s.match(/by \<a href="\/user\/([^\/]*)\//) || ""
            puts build_broken_by_username
            if build_broken_by_username && build_broken_by_username != ""
              job.merge!("build_broken_by" => "#{build_broken_by_username}" )
            end
          end

          # Last commit by
          if job['color'] == "blue"
            res = Net::HTTP.get URI.parse("#{job['hudson_host']}/job/#{URI.escape(job['name'])}/#{job['lastCompletedBuild']["number"]}/changes")
            if res.to_s.match(/by \<a href="\/user\/([^\/]*)\//)
              last_commit_by_username = res.to_s.match(/by \<a href="\/user\/([^\/]*)\//)[1] || ""
              puts last_commit_by_username
              if last_commit_by_username && last_commit_by_username != ""
                job.merge!("last_commit_by" => "#{last_commit_by_username}" )
              end
            end
          end
          
        end
        @builds_details << server_data["jobs"]
      end
    end
    
    #Tramtracker
    
    uri = URI.parse("http://mobile.itransit.com.au/ttlookup")
    
    # to City
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"ttid" => "1725"})
    response = http.request(request)
    @tramtracker_to_city = response
    puts @tramtracker_to_city.body
    
    # from City
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"ttid" => "2725"})
    response = http.request(request)
    @tramtracker_from_city = response
    puts @tramtracker_from_city.body

    render 'dashboard/index'
  end

end