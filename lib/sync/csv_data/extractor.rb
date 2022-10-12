require 'csv'

module Sync
  module CSV_DATA
    class Extractor
      def extract_data_from_csv(filename)
        return nil unless File.exist?(filename)

        csv = CSV.read(filename, headers: true)

        csv.map do |row|
          next unless row['sgUF'].present? && row['sgUF'] == 'PA'

          {
            deputy_identifier: row['ideCadastro'],
            name: row['txNomeParlamentar'],
            taxpayer: row['cpf'],
            parliamentary_card: row['nuCarteiraParlamentar'],
            legislature_number: row['nuLegislatura'],
            state: row['sgUF'],
            political_party: row['sgPartido'],
            legislature_code: row['codLegislatura'],
            sub_quota_number: row['numSubCota'],
            description: row['txtDescricao'],
            sub_quota_esoecification_number: row['numEspecificacaoSubCota'],
            description_especification: row['txtDescricaoEspecificacao'],
            provider_name: row['txtFornecedor'],
            provider_identifier: row['txtCNPJCPF'],
            document_number: row['txtNumero'],
            document_type: row['indTipoDocumento'],
            issue_date: row['datEmissao'],
            document_value: row['vlrDocumento'],
            gross_value: row['vlrGlosa'],
            net_value: row['vlrLiquido'],
            month: row['numMes'],
            year: row['numAno'],
            installments: row['numParcela'],
            passenger_name: row['txtPassageiro'],
            leg_trip: row['txtTrecho'],
            batch: row['numLote'],
            refund: row['numRessarcimento'],
            restitution: row['vlrRestituicao'],
            requester_id: row['nuDeputadoId'],
            document_url: row['urlDocumento']
          }
        end.compact
      end
    end
  end
end
