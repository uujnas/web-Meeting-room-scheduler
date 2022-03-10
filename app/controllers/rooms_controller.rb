# Rooms Controller
class RoomsController < DashboardsController
  before_action :set_room, only: %i[show edit update destroy]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  def show; end

  # GET /rooms/new
  def new
    @room = Room.new
    authorize! :create, Room
  end

  # GET /rooms/1/edit
  def edit
    authorize! :update, Room
  end

  # POST /rooms
  def create
    authorize! :create, Room
    @room = Room.new(room_params)
    @room.user = current_user

    if @room.save
      redirect_to rooms_path, notice: "Room was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if @room.update(room_params)
      redirect_to room_url(@room), notice: "Room was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  def destroy
    authorize! :update, Room
    @room.destroy

    redirect_to rooms_url, notice: "Room was successfully destroyed."
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:description)
  end
end
