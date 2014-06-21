class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:vote]

  def vote
    @post = Post.find(params[:post_id])
    @vote = Vote.find(params[:post_id], params[:user_id])
    score_change = 0
    #If the user has not voted on this link, change the score accordingly.
    if @vote.blank?
      score_change = params[:score]
    elsif @vote.is_upvote != params[:score]
      #Change the direction of the vote stored in the database
      @vote.update_attribute :is_upvote, !@vote.is_upvote
      #If the user is down-voting a previously upvoted post:
      if @vote.is_up
        score_change = -2
      #If the user is up-voting a previously down-voted post:
      else
        score_change = 2
      end
    end
    #Don't do anything if the user isn't allowed to up-vote this.
    if score_change != 0
      @post.update_attribute :score, @post.score + score_change
      #Create vote object indicating the user's vote
      vote = Vote.new(is_upvote: params[:score], post_id: params[:post_id], user_id: current_user.id)
      vote.save
    end
    render_text @post.score
  end
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :url, :username, :votes)
    end
end
