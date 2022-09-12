class BooksController < ApplicationController
    
    def new
      @book = Book.new
  end
  
    def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      flash[:success] = 'Book was successfully created'
      redirect_to book_path(@book.id) 
    else
       flash.now[:danger] = "I got registration error "
      @books = Book.all
      render :index
    end
  end

  def index
      @books = Book.all
      @book = Book.new
  end

  def show
     @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to books_path   # 投稿一覧画面へリダイレクト  
  end
  
  def update
      @book = Book.find(params[:id])
      
     if @book.update(book_params)
      flash[:success] = 'Book was successfully updated'
      redirect_to book_path(@book.id) 
   
    else
       flash.now[:danger] = "I got registration error " 
        @books = Book.all
      render :edit
    end
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end  


