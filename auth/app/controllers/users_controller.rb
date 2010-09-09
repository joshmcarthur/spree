class UsersController < Spree::BaseController
  resource_controller
  
  # before_filter :require_no_user, :only => [:new, :create]
  # before_filter :require_user, :only => [:show, :edit, :update]

  ssl_required :new, :create, :edit, :update, :show
  
  actions :all, :except => [:index, :destroy]

  show.before do
    @orders = @user.orders.complete 
  end
  new_action.before do
    flash.now[:notice] = I18n.t(:please_create_user) unless User.admin_created?
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      self.notice = t("account_updated")
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  private

    def object
      @object ||= current_user
    end

    def accurate_title
      I18n.t(:account)
    end

end

