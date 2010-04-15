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

          if job['lastSuccessfulBuild'] && job['color'] == 'red'
            res = Net::HTTP.get(URI.parse("#{job['hudson_host']}/job/#{URI.escape(job['name'])}/#{job['lastSuccessfulBuild']["number"] + 1}/changes"))
            build_broken_by_username = res.to_s.match(/by \<a href="\/user\/([^\/]*)\//) || ""
            if build_broken_by_username && build_broken_by_username != ""
              job.merge!("build_broken_by" => "#{build_broken_by_username}" )
            end
          end

        end
        @builds_details << server_data["jobs"]
      end
    end

    render 'dashboard/index'
  end

end