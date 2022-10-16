module PoliticalPartyHelper
  CUSTOM_POLITICAL_PARTY_NAMES = {
    'MDB' => 'MOVIMENTO DEMOCRÁTICO BRASILEIRO',
    'PTB' => 'PARTIDO TRABALHISTA BRASILEIRO',
    'PDT' => 'PARTIDO DEMOCRÁTICO TRABALHISTA',
    'PT' => 'PARTIDO DOS TRABALHADORES',
    'PCdoB' => 'PARTIDO COMUNISTA DO BRASIL',
    'PSB' => 'PARTIDO SOCIALISTA BRASILEIRO',
    'PSDB' => 'PARTIDO DA SOCIAL DEMOCRACIA BRASILEIRA',
    'AGIR' => 'AGIR',
    'PSC' => 'PARTIDO SOCIAL CRISTÃO',
    'PMN' => 'CIDADANIA',
    'PV' => 'PARTIDO VERDE',
    'AVANTE' => 'AVANTE',
    'PP' => 'PROGRESSISTAS',
    'PSTU' => 'PARTIDO COMUNISTA BRASILEIRO',
    'PRTB' => 'PARTIDO RENOVADOR TRABALHISTA BRASILEIRO',
    'DC' => 'DEMOCRACIA CRISTÃ0',
    'PCO' => 'PARTIDO DA CAUSA OPERÁRIA',
    'PODE' => 'PODEMOS',
    'REPUBLICANOS' => 'REPUBLICANOS',
    'PSOL' => 'PARTIDO SOCIALISMO E LIBERDADE',
    'PL' => 'PARTIDO LIBERAL	',
    'PSD' => 'PARTIDO SOCIAL DEMOCRÁTICO',
    'PATRIOTA' => 'PATRIOTA',
    'PROS' => 'PARTIDO REPUBLICANO DA ORDEM SOCIAL',
    'SOLIDARIEDADE' => 'SOLIDARIEDADE',
    'NOVO' => 'PARTIDO NOVO',
    'REDE' => 'REDE SUSTENTABILIDADE	',
    'PMB' => 'PARTIDO DA MULHER BRASILEIRA',
    'UP' => 'UNIDADE POPULAR',
    'PSL' => 'Partido Social Liberal',
    'UNIÃO' => 'UNIÃO'
  }.freeze

  def self.political_party_name_from_political_party_code(political_party)
    return '' unless political_party.present?
    CUSTOM_POLITICAL_PARTY_NAMES.fetch(political_party, nil)
  end
end
