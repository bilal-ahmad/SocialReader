class HomeController < ApplicationController
  before_filter :parse_signed_request, except: :change_sharing_status
  @@parse_signed_request

  def index
    fb_id = @@parse_signed_request ? @@parse_signed_request['user_id'] : params[:fb_id]
    @user = User.find_by_fb_id(fb_id)
    @user = create_user(fb_id, params[:token]) if @user.blank? and params[:token].present?
    if params[:q].present?
      @news = News.order(:title).where('title like ?', "%#{params[:q]}%").limit(60)
    else
      @news = (params[:type].present? and params[:type] != 'Headlines') ? News.where('news_type like ? OR category like ?', "%#{params[:type]}%", "%#{params[:type]}%").group(:id).order("published_at DESC").limit(60) : News.order('published_at DESC').limit(60)
      if request.xhr?
        render :partial => 'news', :layout => false if params[:type] # respond to Ajax request
      end
    end
  end

  def search
    @news = News.order(:title).where('title like ?', "%#{params[:q]}%").limit(60)
    render :partial => 'news', :layout => false
  end

  def validated_user
    if params[:code].present?
      user_info = request.env['omniauth.auth'].info
      uid = request.env['omniauth.auth'].uid
      user = User.find_by_fb_id(uid)
      if user.blank?
        User.create(fb_id:uid , first_name:user_info['first_name'], last_name:user_info['last_name'],
                    name:user_info['name'], email:user_info['email'],
                    image:user_info['image'], token:request.env['omniauth.auth'].credentials['token'])
      end
      redirect_to FB_Canvas_URL
    end
  end

  def create_user(fb_id, token)
    graph = Koala::Facebook::API.new(token)
    user_info = graph.fql_query("select uid, first_name, last_name, email, name, pic_square from user where uid = #{fb_id}").first
    User.create(fb_id:user_info['uid'] , first_name:user_info['first_name'], last_name:user_info['last_name'],
                name:user_info['name'], email:user_info['email'],
                image:user_info['pic_square'], token:token)

  end

  def validate_user
    if Rails.env.production?
      @auth_url = Authentication_URL
    elsif Rails.env.development?
      @auth_url = "http://localhost:3000/auth/facebook"
    end
    #redirect_url =<<-EOS
    #<script>
    #  top.location.href="#{@auth_url}";
    #</script>
    #EOS
    #render :inline => redirect_url
  end

  def change_sharing_status
    user =  User.find_all_by_fb_id(params[:fb_id]).first
    if user.sharing
      user.update_attributes(sharing:false)
      render :json => {'response'=> false}
    else
      user.update_attributes(sharing:true)
      render :json => {'response'=> true}
    end
  end

end
