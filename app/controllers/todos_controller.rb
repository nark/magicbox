class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :done, :undone]
  add_breadcrumb "To Do"

  # GET /todos
  # GET /todos.json
  def index
    @todos = current_user.todos.where(todo_status: :todo).limit(20)
    @dones = current_user.todos.where(todo_status: :done).limit(20)
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_back fallback_location: todos_url, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_back fallback_location: todos_url, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def done
    @todo.todo_status = :done
    @todo.save
    redirect_back fallback_location: todos_url
  end


  def undone
    @todo.todo_status = :todo
    @todo.save
    redirect_back fallback_location: todos_url
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:todo_status, :user_id, :date, :body, :notify_email, :notify_push, :renotify_every_minute)
    end
end
