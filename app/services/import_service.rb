class ImportService < ApplicationService
  attr_reader :statement

  def initialize(statement_param)
    @path = statement_param.path
  end

  # def call
  #   xlsx = Roo::Excelx.new(@path)
  #   #xlsx = Roo::Spreadsheet.open(@path)
  #
  #   statement_import(xlsx)
  # end

  def call
    sheet = Roo::Spreadsheet.open(@path, extension: :xlsx)
    sheet.parse(header_search: [/\D/]).each do |row|
      next unless row.uniq.to_s.match?(/\d{8,}/)

      @debt_kvc = row["Дебет"].to_i
      @personal_account_kvc = row["Лицевой счет"].to_i

      @owner_info_kvc = {personal_account: @personal_account_kvc, debt: @debt_kvc} if @debt_kvc > 0
    end

    RegisterOfOwner.all.collect { |owner|  ["#{owner.personal_account}"]  }.each do |id|
      RegisterOfOwner.all if @owner_info_kvc[:personal_account] == id.join("").to_i
    end
  end

  # private
  #
  # def statement_import(xlsx)
  #   n = 0
  #
  #   xlsx.each_row_streaming do |row|
  #     n += 1
  #     next if n < 9
  #
  #     processing(row) if (row.first.present? && row.first.value.chomp.to_i)
  #      @find_pers_account = processing(row)[:personal_account]
  #     # puts "#{@find_pers_account}"
  #   end
  # end
  #
  # def processing(row)
  #   row.map do |value|
  #     @personal_account = value.value.chomp if value.coordinate[1] == 3
  #     @debt = value.value.chomp.to_f if value.coordinate[1] == 32
  #   end
  #
  #   owner_info = {personal_account: @personal_account, debt: @debt}
  # end
end
