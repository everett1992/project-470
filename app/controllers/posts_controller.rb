class PostsController < DwellingItemsController
	before_filter :get_dwelling_and_post
	before_filter :ensure_post_belongs_to_current_user, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @dwelling.posts.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = @dwelling.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @dwelling.posts.new(params[:post])
    @post.owner = current_user


    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  def get_dwelling_and_post
    @dwelling = current_dwelling
    if params[:id]
      @post = @dwelling.posts.find(params[:id])
    end
  end

	def ensure_post_belongs_to_current_user
		permission_denied unless current_user == @post.owner
	end
end
