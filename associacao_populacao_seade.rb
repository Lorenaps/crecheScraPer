require 'csv'
def associa_populacao dir, arquivo_saida, filas_distritos, dados_populacao
  fila = {}
  populacao = {}

  CSV.foreach(filas_distritos) do |row|
    distrito = row[0]
    f = row[1]

    fila[distrito] = f
  end

  CSV.foreach(dados_populacao) do |row|
    distrito = row[0]
    p = row[1]

    populacao[distrito] = p
  end

  puts populacao
  #write
  CSV.open(dir + arquivo_saida, "wb") do |csv|
    csv << ["Distrito", "Indice per capta (*100)", "Tamanho da fila", "Populacao"]
    i = 1
    fila.each do |k, v|
      csv << [k, (v.to_f / populacao[k].to_f) * 100, v.to_f, populacao[k].to_f] if i!= 1
      i += 1
    end
  end
end
################################################################
#*****************PARA RODAR ESSE ARQUIVO***********************
################################################################

dir = "/var/www/html/cuidando2/creches/Site/scripts/2014-12-18 12:50/"#Diretório onde estão os arquivos
associa_populacao dir, "filas.csv", dir + "agrupado_por_distritos.csv", "data/populacao_0_4_anos.csv"
