class ImportService < ApplicationService
  attr_reader :statement

  def initialize(statement_param)
    @statement = statement_param
  end

  def call
    data = Roo::Spreadsheet.open(@statement.path, extension: :xlsx)
    @owner_info_kvc = []

    headers = data.row(1)
    data.each_with_index do |row, idx|
      next if idx.zero?

      user_data = Hash[headers.zip(row)]
      next if user_data["Дебет"].to_i.zero?

      @debt_kvc = user_data["Дебет"].to_i
      @personal_account_kvc = user_data["Лицевой счет"].to_i
      @owner_info_kvc << { personal_account: @personal_account_kvc, debtor: true }
    end

    @owner_list = []

    @owner_info_kvc.each do |value|
      owner = RegisterOfOwner.find_by(personal_account: value[:personal_account])
      @owner_list << owner if owner.present?
    end

    @owner_list.each do |value|
      value.debtor = true
    end
  end
end
