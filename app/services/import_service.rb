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
#      @owner_info_kvc << {personal_account: @personal_account_kvc, debtor: true}
      @owner_info_kvc << {personal_account: @personal_account_kvc}
    end

    @owner_list = []

    @owner_info_kvc.map do |value|
      owner = RegisterOfOwner.find_by(personal_account: value[:personal_account])
      @owner_list << owner if owner.present?
    end

    @owner_list
  end
end
