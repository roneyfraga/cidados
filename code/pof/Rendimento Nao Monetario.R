#                            POF 2017-2018
  
#  PROGRAMA PARA GERA??O DA ESTIMATIVA PONTUAL DO ITEM RENDIMENTO N?O MONET?RIO
#                       N?VEL GEOGR?FICO - BRASIL 

# ? preciso executar antes o arquivo "Leitura dos Microdados - R.R"
# que se encontra no arquivo compactado "Programas_de_Leitura.zip"
# Este passo ? necess?rio para gerar os arquivos com a extens?o .rds
# correspondentes aos arquivos com extens?o .txt dos microdados da POF

# "....." indica a pasta/diret?rio de trabalho no HD local separados por "/"
# onde se encontram os arquivos .txt descompactados do arquivo Dados_aaaammdd.zip
# Exemplo: setwd("c:/POF2018/Dados_aaaammdd/")

setwd(".....") # Caminho onde se encontram as bases de dados



# Parte 1 - Para cada Unidade de Consumo (UC), somar todos os valores referentes
# as despesas n?o monet?rias (quando o quesito Forma de Aquisi??o (V9002) for de 7 a 11). 
# Exceto, os valores do c?digo 00101 (Aluguel Estimado).


# Leitura do REGISTRO - DESPESA COLETIVA

despesa_coletiva <- readRDS("DESPESA_COLETIVA.rds")

# [1] Anualiza??o e expans?o dos valores utilizados para a obten??o dos resultados
#    (vari?veis V8000_defla e V1904_defla). O quesito V1904_defla se refere a despesa 
#    com "INSS e Outras Contribui??es Trabalhistas", que ? utilizado no grupo 
#    "Outras despesas correntes".

#    a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso espec?fico 
#       dos quadros 10 e 19, cujas informa??es se referem a valores mensais, utilizamos
#       tamb?m o quesito V9011 (n?mero de meses).
#       Os valores s?o anualizados para depois se obter uma m?dia mensal.

#    b) Para expandir, utilizamos o quesito "peso_final".

#    c) Posteriormente, o resultado ? dividido por 12 para obter a estimativa mensal. 

# [2] Filtrando somente as informa??es N?o Monet?rias
  
desp_coletiva <- 
  transform( 
    subset( despesa_coletiva,
            V9002 >= 7 
            ) , # [2]
    valor_mensal = ifelse( QUADRO==10|QUADRO==19,
                           (V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12, 
                           (V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12
                           )  # [1] 
    )[ , c( "COD_UPA" , "NUM_DOM" , "NUM_UC" , "valor_mensal" ) ]


#  Leitura do REGISTRO - CADERNETA COLETIVA (Question?rio POF 3)

caderneta_coletiva <- readRDS("CADERNETA_COLETIVA.rds")

# [1] Anualiza??o e expans?o dos valores utilizados para a obten??o dos resultados 
#     (vari?vel V8000_defla). 

#     a) Para anualizar, utilizamos o quesito "fator_anualizacao". Os valores s?o
#        anualizados para depois se obter uma m?dia mensal.

#     b) Para expandir, utilizamos o quesito "peso_final".

#     c) Posteriormente, o resultado ? dividido por 12 para obter a estimativa mensal.

# [2] Filtrando somente as informa??es N?o Monet?rias

cad_coletiva <- 
  transform( 
    subset( caderneta_coletiva,
            V9002 >= 7
            ) ,  # [2]
    valor_mensal=(V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12 # [1]
    )[ , c( "COD_UPA" , "NUM_DOM" , "NUM_UC" , "valor_mensal" ) ]

rm(caderneta_coletiva)


# Leitura do REGISTRO - DESPESA INDIVIDUAL 

despesa_individual <- readRDS("DESPESA_INDIVIDUAL.rds")

# [1] Anualiza??o e expans?o dos valores utilizados para a obten??o dos resultados 
#     (vari?vel V8000_defla). 

#     a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso espec?fico 
#       dos quadros 44, 47, 48, 49 e 50, cujas informa??es se referem a valores mensais, 
#       utilizamos tamb?m o quesito V9011 (n?mero de meses).
#       Os valores s?o anualizados para depois se obter uma m?dia mensal.

#     b) Para expandir, utilizamos o quesito "peso_final".

#     c) Posteriormente, o resultado ? dividido por 12 para obter a estimativa mensal.

# [2] Filtrando somente as informa??es N?o Monet?rias

desp_individual <-
  transform( 
    subset( despesa_individual,
            V9002 >= 7
            ) , # [2]
    valor_mensal = ifelse( QUADRO==44|QUADRO==47|QUADRO==48|QUADRO==49|QUADRO==50 ,
                           (V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12 ,
                           (V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12
                           ) # [1]
             )[ , c( "COD_UPA" , "NUM_DOM" , "NUM_UC" , "valor_mensal" ) ]

rm(despesa_individual)

# Jun??o dos registros, quem englobam os valores n?o monet?rios

junta_nao_monet <- 
  rbind( desp_coletiva , 
         cad_coletiva , 
         desp_individual
         )

# Somas dos valores n?o monet?rios por Unidade de Consumo

parte1 <- aggregate(valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC , data=junta_nao_monet , sum )
names(parte1) <- c( "cod_upa" , "num_dom" , "num_uc", "soma_nao_monet" )



# Parte 2 - Para cada Unidade de Consumo (UC), subtrair do valor referente 
# ao c?digo 00101 (Aluguel Estimado) a soma dos valores das despesas monet?rias 
# (quando o quesito Forma de Aquisi??o (V9002) for de 1 a 6) referentes aos seguintes c?digos:
  
#  C?digos do quadro 8 ? 8001 a 8024,  8026 a 8068 e  8999
#  C?digos do quadro 10 ? 10006 e 10011
#  C?digos do quadro 12 ? 12005 a 12008, 12010 a 12015, 12017 a 12020, 12023 a 12025, 
#  12027 a 12036  e 12999

# S? considerar quando a diferen?a entre o Aluguel Estimado e a soma desses c?digos
# for maior que 0.


#  Leitura do REGISTRO -  - ALUGUEL ESTIMADO 

aluguel_estimado <- readRDS("ALUGUEL_ESTIMADO.rds")

#  Anualiza??o e expans?o dos valores utilizados para a obten??o dos resultados 
#  (vari?vel V8000_defla). 

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". Neste registro, 
#    cujas informa??es se referem a valores mensais de alugueis, utilizamos tamb?m
#    o quesito V9011 (n?mero de meses). 
#    Os valores s?o anualizados para depois se obter uma m?dia mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado ? dividido por 12 para obter a estimativa mensal.
  
alu_estimado <- 
  transform( aluguel_estimado,
             valor_mensal=(V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12 
             )[ , c( "COD_UPA" , "NUM_DOM" , "NUM_UC" , "valor_mensal"  ) ]

rm(aluguel_estimado)

# Somas dos valores de Aluguel Estimado por Unidade de Consumo

aluguel_estimado <- aggregate(valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC , data=alu_estimado , sum )
names(aluguel_estimado) <- c( "cod_upa" , "num_dom" , "num_uc" , "soma1" )

# Soma dos c?digos dos quadros 8, 10 e 12 descritos na introdu??o da Parte 2,
# segundo cada Unidade de Consumo

despesa_coletiva <- 
  transform( despesa_coletiva ,
             codigo = trunc(V9001/100)
             )

codigos_subtracao <- 
  transform( 
    subset( despesa_coletiva ,
            V9002 <= 6 & 
              (
                (codigo >= 8001 & codigo <= 8024) | 
                  (codigo >= 8026 & codigo <= 8068) | 
                  codigo == 8999 |
                  codigo == 10006 |
                  codigo == 10011 |
                  (codigo >= 12005 & codigo <= 12008) | 
                  (codigo >= 12010 & codigo <= 12015) | 
                  (codigo >= 12017 & codigo <= 12020) | 
                  (codigo >= 12023 & codigo <= 12025) | 
                  (codigo >= 12027 & codigo <= 12036) | 
                  codigo == 12999
               )
            ) ,
    valor_mensal = ifelse( QUADRO == 10 ,
                           (V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12 ,
                           (V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12
                           )
    )[ , c( "COD_UPA" , "NUM_DOM" , "NUM_UC" , "valor_mensal"  ) ]

rm(despesa_coletiva)

cod_subtracao <- aggregate(valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC , data=codigos_subtracao , sum )
names(cod_subtracao) <- c( "cod_upa" , "num_dom" , "num_uc" , "soma2" )

# Calculando a diferen?a entre o valor do Aluguel Estimado e a
# soma dos c?digos dos quadros 8, 10 e 12 descritos na introdu??o da Parte 2,
# segundo cada Unidade de Consumo

parte2 <-
  subset(
    transform(
      merge( aluguel_estimado , cod_subtracao , all.x = T , all.y = T ) ,
      dif = ifelse( is.na(soma1) , 0 , soma1 ) - ifelse( is.na(soma2) , 0 , soma2 )
    )[ , c("cod_upa" , "num_dom" , "num_uc" , "dif")] ,
    dif > 0
  )

# Somando os valores obtidos nas partes 1 e 2 

merge_duas_partes <-
  transform(
    merge( parte1 , parte2 , all.x = T , all.y = T ) ,
    soma = ifelse( is.na(soma_nao_monet) , 0 , soma_nao_monet ) + ifelse( is.na(dif) , 0 , dif )
    )[ , c("cod_upa" , "num_dom" , "num_uc" , "soma")]

soma_final <- sum(merge_duas_partes$soma)
             

# Leitura do REGISTRO - MORADOR, necess?rio para o c?lculo do n?mero de UC's expandido.
# Vale ressaltar que este ? o ?nico registro dos microdados que engloba todas as UC's

# Extraindo todas as UC's do arquivo de morador

morador_uc <- 
  unique( 
    readRDS( 
      "MORADOR.rds" 
    ) [ ,
        c( "UF","ESTRATO_POF","TIPO_SITUACAO_REG","COD_UPA","NUM_DOM","NUM_UC",
           "PESO_FINAL"
        ) # Apenas vari?veis com informa??es das UC's no arquivo "MORADOR.rds"
        ] ) # Apenas um registro por UC

# Calculando o n?mero de UC's expandido 
# A cada domic?lio ? associado um peso_final e este ? tamb?m associado a cada uma de suas unidades de consumo 
# Portanto, o total de unidades de consumo (familias) expandido, ? o resultado da soma dos pesos_finais a elas associados

soma_familia <- sum( morador_uc$PESO_FINAL )

# Calculando o rendimento n?o monet?rio m?dio mensal (resultado final)

renda_nao_monet <-
  data.frame(
    soma_final = soma_final ,
    soma_familia = soma_familia ,
    media = round( soma_final / soma_familia , 2 )
  )

