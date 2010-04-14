Admin.controllers :buildservers do

  get :index do
    @buildservers = Buildserver.all
    render 'buildservers/index'
  end

  get :new do
    @buildserver = Buildserver.new
    render 'buildservers/new'
  end

  post :create do
    @buildserver = Buildserver.new(params[:buildserver])
    if @buildserver.save
      flash[:notice] = 'Buildserver was successfully created.'
      redirect url(:buildservers, :edit, :id => @buildserver.id)
    else
      render 'buildservers/new'
    end
  end

  get :edit, :with => :id do
    @buildserver = Buildserver.find(params[:id])
    render 'buildservers/edit'
  end

  put :update, :with => :id do
    @buildserver = Buildserver.find(params[:id])
    if @buildserver.update_attributes(params[:buildserver])
      flash[:notice] = 'Buildserver was successfully updated.'
      redirect url(:buildservers, :edit, :id => @buildserver.id)
    else
      render 'buildservers/edit'
    end
  end

  delete :destroy, :with => :id do
    buildserver = Buildserver.find(params[:id])
    if buildserver.destroy
      flash[:notice] = 'Buildserver was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Buildserver!'
    end
    redirect url(:buildservers, :index)
  end
end