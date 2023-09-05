class ImportService < ApplicationService
  attr_reader :statement

  def initialize(statement_param)
  @path = statement_param.path
  end

  def call
    xlsx = Roo::Excelx.new(@path)
    #xlsx = Roo::Spreadsheet.open(@path)
    statement_import(xlsx)
  end

  private

  def statement_import(xlsx)
    n = 0
    xlsx.each_row_streaming do |row|
      n += 1
      next if n < 9
      processing(row) if (row.first.present? && row.first.value.chomp.to_i)
    end
  end

  def processing(row)
    row.map do |value|
      @personal_account = value.value.chomp if value.coordinate[1] == 3
      @debt = value.value.chomp.to_f if value.coordinate[1] == 32
    end
    owner_info = {personal_account: @personal_account, debt: @debt}
    byebug
  end
end
