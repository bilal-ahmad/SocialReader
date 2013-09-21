class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  before_filter :parse_signed_request
  @@parse_signed_request

  def index
    @news = params[:type].present? ? News.where('type = ?', params[:type]).order("published_at DESC") : News.order("published_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def get_news_title
    @news = News.order(:title).where('title like ?', "%#{params[:term]}%")
    render json: @news.map(&:title)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    fb_id = @@parse_signed_request ? @@parse_signed_request['user_id'] : params[:fb_id]
    @user = User.find_by_fb_id(fb_id)
    @news = params[:q].present? ? News.order(:title).where('title like ?', "%#{params[:q]}%").limit(30).first : News.find(params[:id])
    @related_news = News.where('news_type like ? OR category like ?', "%#{@news.news_type}%", "%#{@news.category}%").group(:id).order("published_at DESC").limit(20)
    if request.xhr?
      render :partial => 'show', :layout => false
    else
      render layout: params[:q].present? ? false : 'news_detail'
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end
end
