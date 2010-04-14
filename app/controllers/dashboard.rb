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
      server_data = JSON.parse(Net::HTTP.get(URI.parse("http://#{URI.escape(server.address)}/api/json?depth=1")))
      server_data["jobs"].each do |job|
        job.merge!("hudson_host" => "#{server.address}")
      end
      @builds_details << server_data["jobs"]
    end
    
    render 'dashboard/index'
  end

end