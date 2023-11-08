class ImportService < ApplicationService
  attr_reader :statement

  def initialize(statement_param)
    @path = statement_param.path
  end

  def call
    data = Roo::Spreadsheet.open(@path, extension: :xlsx)
    @owner_info_kvc = []

    headers = data.row(1)
    data.each_with_index do |row, idx|
      next if idx == 0

      user_data = Hash[[headers, row].transpose]
      next if user_data["Дебет"].to_i == 0

      @debt_kvc = user_data["Дебет"].to_i
      @personal_account_kvc = user_data["Лицевой счет"].to_i
      @owner_info_kvc << {personal_account: @personal_account_kvc, debtor: true}
    end

    @owner_list = []

    @owner_info_kvc.map do |value|
      owner = RegisterOfOwner.where(debtor: false, personal_account: value[:personal_account])
      @owner_list << owner if owner.present?
    end

    @owner_list
  end

  # def call
  #   sheet = Roo::Spreadsheet.open(@path, extension: :xlsx)
  #   @owner_info_kvc = []
  #
  #   sheet.parse(header_search: [/\D/]).each do |row|
  #     @debt_kvc = row["Дебет"].to_i
  #     @personal_account_kvc = row["Лицевой счет"].to_i
  #     @owner_info_kvc << {personal_account: @personal_account_kvc, debt: @debt_kvc} if @debt_kvc > 0
  #   end
  #
  #   owner_list = []
  #
  #   @owner_info_kvc.map do |value|
  #     owner = RegisterOfOwner.find_by(personal_account: value[:personal_account])
  #     if owner.present?
  #       owner_list << {
  #         id: owner.id,
  #         email: owner.email,
  #         middle_name: owner.middle_name,
  #         first_name: owner.first_name,
  #         last_name: owner.last_name,
  #         personal_account: owner.personal_account,
  #         city: owner.city,
  #         street: owner.street,
  #         house_no: owner.house_no,
  #         apartment_no: owner.apartment_no,
  #         number_owners: owner.number_owners,
  #         phone: owner.phone,
  #         home_activation_date: owner.home_activation_date,
  #         subscriber_blocking_date: owner.subscriber_blocking_date,
  #         contractor: owner.contractor,
  #         debtor: true
  #       #  debt: value[:debt]
  #       }
  #     end
  #   end
  #
  #   owner_list
  # end

  # private
  #
  # def customer_transaction
  #   RegisterOfOwner.create(owner_list).transaction do
  #   end
  # end
end
