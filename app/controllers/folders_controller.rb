class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :new_subfolder]

  def new_subfolder
    @subfolder = @folder.subfolders.build
  end
  
  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.all
  end

  # GET /folders/1
  # GET /folders/1.json
  # disable show in favor of edit
  def show
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)
    
    # get ranks of all the (future) siblings of this folder-to-be
    if @folder.parent
      next_rank = (@folder.parent.items.collect{|e|e.rank || 0}.max || 0) + 1
    else
      next_rank = (Folder.top_level.collect{|e|e.rank || 0}.max || 0) + 1
    end
    
    @folder.rank = next_rank

    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @parent = @folder.parent
    
    # destroy descendant folders
    @folder.descendants.each {|e| e.destroy}
    
    # destruction of descendant documents is automatic because embedded
    
    # destroy the folder itself
    @folder.destroy
    
    respond_to do |format|
      format.html { redirect_to @parent ? @parent : folders_url, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:title, :parent_id, :items_attributes=> [:id, :rank])
    end
end
