class ImportService < ApplicationService
  attr_reader :statement

  def initialize(statement_param)
    @statement = statement_param
  end

  def call
    data = Roo::Spreadsheet.open(@statement.path, extension: :xlsx)
    owner_info_kvc = []

    headers = data.row(1)
    data.each_with_index do |row, idx|
      next if idx.zero?

      user_data = Hash[headers.zip(row)]
      next if user_data["Дебет"].to_i.zero?

      @debt_kvc = user_data["Дебет"].to_i
      personal_account_kvc = user_data["Лицевой счет"].to_i
      #@owner_info_kvc << { personal_account: @personal_account_kvc, debtor: true }
      #зачем нам массив хэшей, если все это затеяно ради списка просто
      owner_info_kvc << personal_account_kvc
    end


    @owner_list = get_debtors(owner_info_kvc)

  end

  private

  def get_debtors(owners_personal_accounts)
    debt_owners = []
    RegisterOfOwner.all.each do |owner|
      if owners_personal_accounts.include?(owner.personal_account) && owner.debtor == false
        owner.debtor = true
        owner.save!
        debt_owners << owner
      elsif  !owners_personal_accounts.include?(owner.personal_account) && owner.debtor == true
        owner.debtor = false
        owner.save!
      end
      debt_owners
    end
  end
end
