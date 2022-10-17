require 'csv'

module Sync
  module CSVData
    class Extractor

      def extract_data_from_csv(filename)
        return nil unless File.exist?(filename)

        csv_data = []
        CSV.foreach(filename, headers: true, encoding: 'bom|utf-8', col_sep: ';') do |row|
          next unless row['sgUF'] == 'PA'

          csv_data << row_data(row)
        end

        csv_data.compact
      end

      def row_data(row)
        new_row = {}

        new_row.merge!(deputy_row(row),
                       legislature_row(row),
                       deputy_quota_row(row),
                       provider_row(row),
                       invoice_row(row))
      end

      def deputy_row(row)
        {
          deputy_identifier: row['ideCadastro'],
          name: row['txNomeParlamentar'],
          taxpayer: row['cpf']
        }.freeze
      end

      def legislature_row(row)
        {
          parliamentary_card: row['nuCarteiraParlamentar'],
          legislature_number: row['nuLegislatura'],
          state: row['sgUF'],
          political_party: row['sgPartido'],
          legislature_code: row['codLegislatura']
        }.freeze
      end

      def deputy_quota_row(row)
        {
          sub_quota_number: row['numSubCota'],
          description: row['txtDescricao'],
          sub_quota_specification_number: row['numEspecificacaoSubCota'],
          description_specification: row['txtDescricaoEspecificacao']
        }.freeze
      end

      def provider_row(row)
        {
          provider_name: row['txtFornecedor'],
          provider_identifier: row['txtCNPJCPF']
        }.freeze
      end

      def invoice_row(row)
        {
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
        }.freeze
      end

    end
  end
end
