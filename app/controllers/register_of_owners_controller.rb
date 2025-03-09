class RegisterOfOwnersController < ApplicationController
  before_action :find_register_of_owner, only: %i[show edit update destroy upload_scan]

  def index
    if params[:search].present?
      @register_of_owners = RegisterOfOwner.where("street || house_no || personal_account || ' ' || contractor LIKE ?", "%#{params[:search]}%")
                                            .paginate(page: params[:page], per_page: 10)
      flash[:notice] = "Записи в базе данных не найдены." if @register_of_owners.blank?
    else
      @register_of_owners = RegisterOfOwner.all.paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @register_of_owner = RegisterOfOwner.new
  end

  def form
    @register_of_owner = RegisterOfOwner.new
  end

  def create
  @register_of_owner = RegisterOfOwner.new(register_of_owner_params)
  @register_of_owner.scans.attach(params[:scans])

  # Обработка чекбокса для даты блокировки
  if params[:register_of_owner][:subscriber_blocking_date_enabled] == "1"
    @register_of_owner.subscriber_blocking_date = params[:register_of_owner][:subscriber_blocking_date]
  else
    @register_of_owner.subscriber_blocking_date = nil
  end

  if @register_of_owner.save
    flash[:success] = 'Собственник добавлен!'

    # Создаем запись в AccessRegistry с данными из формы
    AccessRegistry.create(
      register_of_owners_id: @register_of_owner.id,
      serial_number: @register_of_owner.serial_number,    # Используем серийный номер из формы
      date_application: DateTime.current,                  # Дата заявки — текущая дата
      date_issue: DateTime.current                         # Дата выдачи — текущая дата
    )

    redirect_to action: "index"
  else
    # Если ошибка уникальности, то добавляем специальное сообщение об ошибке
    if @register_of_owner.errors[:personal_account].any?
      flash[:error] = "Лицевой счет уже существует!"
    else
      flash[:error] = "Не удалось добавить собственника!"
    end
    render :new, status: :unprocessable_entity
  end
end

  # Метод для загрузки сканов
  def upload_scan
    if params[:register_of_owner][:scans].present?
      params[:register_of_owner][:scans].each do |scan|
        @register_of_owner.scans.attach(scan)
      end
      redirect_to @register_of_owner, notice: 'Документы успешно загружены!'
    else
      redirect_to @register_of_owner, alert: 'Пожалуйста, выберите файл для загрузки.'
    end
  end

  # первоначальный
  # def create
  #   @register_of_owner = RegisterOfOwner.new(register_of_owner_params)
  #   @register_of_owner.scans.attach(params[:scans])
  #
  #   # Обработка чекбокса для даты блокировки
  #   if params[:register_of_owner][:subscriber_blocking_date_enabled] == "1"
  #     @register_of_owner.subscriber_blocking_date = params[:register_of_owner][:subscriber_blocking_date]
  #   else
  #     @register_of_owner.subscriber_blocking_date = nil
  #   end
  #
  #   if @register_of_owner.save
  #     flash[:success] = 'Собственник добавлен!'
  #     AccessRegistry.create(register_of_owners_id: @register_of_owner.id, date_issue: DateTime.current)
  #     redirect_to action: "index"
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def show
  end

  def update
    @register_of_owner.scans.attach(params[:scans])

    # Обработка чекбокса для даты блокировки
    if params[:register_of_owner][:subscriber_blocking_date_enabled] == "1"
      @register_of_owner.subscriber_blocking_date = params[:register_of_owner][:subscriber_blocking_date]
    else
      @register_of_owner.subscriber_blocking_date = nil
    end

    if @register_of_owner.update(register_of_owner_params)
      flash[:success] = 'Данные изменены!'
      redirect_to action: "index"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    if @register_of_owner.destroy
      flash[:success] = 'Собственник удален!'
      redirect_to action: "index"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def import
    if params[:statement].present?
      @owner_list = ImportService.call(params[:statement])
      flash[:success] = "Найдено #{@owner_list&.count} собственников."
    end
  end

  private

  def register_of_owner_params
    params.require(:register_of_owner).permit(
      :first_name, :last_name, :middle_name, :personal_account, :city, :street,
      :house_no, :apartment_no, :number_owners, :phone, :email, :home_activation_date,
      :subscriber_blocking_date, :serial_number, :contractor, :statement, :search, :subscriber_blocking_date_enabled, scans: []
    )
  end

  def find_register_of_owner
    @register_of_owner = RegisterOfOwner.find(params[:id])
  end

  def send_fields_access_registry
    AccessRegistry.new
  end

  def import_data(path)
    xlsx = Roo::Spreadsheet.open(path[:xlsx_path])
    xlsx.sheet(0).each_with_index(personal_account: 'personal_account') do |row, row_index|
      next if row_index == 0 || RegisterOfOwner.find_by(personal_account: row[:personal_account]).present?

      RegisterOfOwner.create(personal_account: row[:personal_account])
    end
  end
end
