class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    # Post.allで、なぜデータベースを参照できるのか？
    # 更新したら文字化けしたぞ。
    # [
    #   "今日からProgateでRailsの勉強するよー！",
    #   "投稿一覧ページ作成中！"
    # ]
  end
  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new #new.html.erbは新規投稿画面だが、@postを使用するので、ここで定義してく。この定義は宙に浮いた感じで気持ちが悪いが
  end

  def create
    @post = Post.new(content: params[:content])
    @post.save
    if @post.save
      flash[:notice] = "Successfully Created!!"
      redirect_to("/posts/index")
    else
      render("posts/new")
      #  newアクションを経由せずに、new.html.erbを直接表示する
    end
  end
  def edit
    @post = Post.find_by(id: params[:id])
    # editアクションでURLのidと同じidの投稿データをデータベースから取得する。その値を初期値そ変シュージの初期として設定する
  end
  def update #投稿を編集する
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
      if @post.save
        flash[:notice] = "Successfully updated!!"
        redirect_to("/posts/index")
      else
        render("posts/edit")
        # 2018/09/15なぜ render("posts/#{@post.id}/edit")ではないのか
      end

  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "Deleted"
    # destroyアクションの場合には、@post.saveはいらない。@post.save
    redirect_to("/posts/index")
  end
end
