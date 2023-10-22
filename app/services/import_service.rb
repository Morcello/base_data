class ImportService < ApplicationService
  attr_reader :statement

  def initialize(statement_param)
    @path = statement_param.path
  end

  def call
    sheet = Roo::Spreadsheet.open(@path, extension: :xlsx)
    @owner_info_kvc = []

    sheet.parse(header_search: [/\D/]).each do |row|
      @debt_kvc = row["Дебет"].to_i
      @personal_account_kvc = row["Лицевой счет"].to_i
      @owner_info_kvc << {personal_account: @personal_account_kvc, debt: @debt_kvc} if @debt_kvc > 0
    end

    owner_list = []

    @owner_info_kvc.map do |value|
      owner = RegisterOfOwner.find_by(personal_account: value[:personal_account])
      if owner.present?
        owner_list << owner.personal_account

      #   owner_list << {
      #     id: owner.id,
      #     personal_account: owner.personal_account,
      #     debt: value[:debt]
      #   }
      end
    end

    owner_list
  end
end
