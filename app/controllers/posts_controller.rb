class PostsController < ApplicationController
    before_action :validate_url_id, only: [:edit, :update, :destroy]

    def index
        #@posts = Post.all
        @posts = Post.order(updated_at: :desc).paginate(page: params[:page], per_page: 3)
    end

    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            flash[:success] = "Post updated."
            redirect_to posts_path
        else
            render 'edit'
        end
    end

    def create
        @post = Post.new(post_params)
        if @post.save()
            flash[:success] = "Post created."
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def destroy
        post = Post.find(params[:id])
        if post.destroy
            flash[:success] = "Post deleted."
        else
            flash[:error] = "Post could not be deleted."
        end
        redirect_to posts_path
    end

    private

    def post_params
        params.require(:post).permit(:image, :caption)
    end

    def validate_url_id
        if !Post.exists?(params[:id])
            redirect_to posts_path
        end
    end
end
