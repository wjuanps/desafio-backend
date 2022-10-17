module MonthHelper
  CUSTOM_MONTH_NAMES = {
    1 => 'Janeiro',
    2 => 'Fevereiro',
    3 => 'Março',
    4 => 'Abril',
    5 => 'Maio',
    6 => 'Junho',
    7 => 'Julho',
    8 => 'Agosto',
    9 => 'Setembro',
    10 => 'Outubro',
    11 => 'Novembro',
    12 => 'Dezembro'
  }.freeze

  def self.month_name_from_month_code(month_code)
    return '' unless month_code.present?

    CUSTOM_MONTH_NAMES.fetch(month_code.to_i, nil)
  end
end
