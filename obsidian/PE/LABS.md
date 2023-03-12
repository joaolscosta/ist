
```r
# Entrada de Dados

# Opção 1: Escrever os dados

bicicletas<-c(4.3,6.8,9.2,7.2,8.7,8.6,6.6,5.2,8.1,10.9,
              7.4,4.5,3.8,7.6,6.8,7.8,8.4,7.5,10.5,6.0,
              7.7,8.1,7.0,8.2,8.4,8.8,6.7,8.2,9.4,7.7,
              6.3,7.7,9.1,7.9,7.9,9.4,8.2,6.7,8.2,6.5)

bicicletas

# Opção 2: Ler os dados de um ficheiro csv a partir da diretoria de trabalho que contém o ficheiro ex1.csv

setwd("C:/Users/UserCarol/Dropbox/My PC (Carol)/Documents/IST_2022-23/R_PE_2022-23/Dados_PE") #Fixar a diret?ria de trabalho
bicicletas1 <- read.csv("ex1.csv", header = TRUE, sep =";", dec = ".")

head(bicicletas1) # Permite visualizar apenas 6 linhas

# Opção 3: Ler os dados de um ficheiro excel diretamente a partir de um link (ter internet ligada!)

install.packages(rio) # Este comando apenas se usa uma vez

library(rio) # Package que permite importar dados de v?rios formatos

urlmy<-"https://web.tecnico.ulisboa.pt/~ist13493/PE_aulas2023/R_Material_exerciciosR/ex1.xlsx"
bicicletas2<-import(urlmy)

head(bicicletas2)

# Algumas Medidas Descritivas

mean(bicicletas) # Média
median(bicicletas) # Mediana

# Construir a função para calcular a moda
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

moda.bic<- getmode(bicicletas) # Moda
print(moda.bic)
table(bicicletas) # Confirmar a moda

quantile(bicicletas,type=2) # Quantis
quantile(bicicletas,type=2)[4]-quantile(bicicletas,type=2)[2]

summary(bicicletas)
fivenum(bicicletas)

var(bicicletas) # Variância
sd(bicicletas) # Desvio Padrão
range(bicicletas) #Mínimo e Máximo
diff(range(bicicletas)) # Amplitude Amostral
100 * sd(bicicletas)/mean(bicicletas) # Coeficiente de Variação

install.packages("moments") # Este comando deve ser usado apenas uma vez
library(moments)
skewness(bicicletas) # Coeficiente de Assimetria
kurtosis(bicicletas) # Coeficiente de Achatamento

## b)

# Quartis e Amplitude Interquartil (ou inter-quantil)

quantile(bicicletas,c(0.25,0.5,0.75),type=2)
IQR(bicicletas)


## c)

# Quantil Amostral de 0.68

quantile(bicicletas,0.68, type=2)


## d)

# Diagrama de Caule-e-Folhas

stem(bicicletas)


## e)

# Histograma e Caixa de Bigodes (ou Boxplot)

par(mfrow=c(1,2))
hist(bicicletas, col="red", main="")
boxplot(bicicletas, col="red", main="") # dividir algum como diferntes
#temos a estrela como diferetentes e os com bola não são tanto.

#####################################################

# Exercício 1.2

## a)

# Entrada dos Dados

setwd("C:/Users/UserCarol/Dropbox/My PC (Carol)/Documents/IST_2022-23/R_PE_2022-23/Dados_PE")
cotinina=read.table("ex2.dat",header=T)
cotinina

# Tabela de Frequências Absolutas e Frequências Relativas (Fumadores e Não Fumadores)

classes=cotinina$classes
class(classes)
faFum<-cotinina$faFumadores
faNFum<-cotinina$faNFumadores
frFum<-faFum/sum(faFum)
frNFum<-faNFum/sum(faNFum)
write.table(cbind(faFum,frFum,faNFum,frNFum))


## b)

# Histogramas de Fumadores e Não Fumadores

par(mfrow=c(1,2))
barplot(faFum,names.arg=classes,main="Fumadores",col="blue",xlab="Nível de Cotinina",
        ylab="Freq. Absol. Cotinina",space=0)
barplot(faNFum,names.arg=classes,main="Não Fumadores",xlab="Nível de Cotinina", col="green",
        ylab="Freq. Absol. Cotinina",space=0)


## c)

# Analisar as Populações Fumadores e Não Fumadores relativamente ao Nível de Cotinina


#####################################################

# Exercício 1.3

## a)

# Entrada dos Dados

rm(list=ls(all=TRUE)) #Remove todos os objetos
mortdata<-read.csv("C:/Users/UserCarol/Dropbox/My PC (Carol)/Documents/IST_2022-23/R_PE_2022-23/Dados_PE/ex3.csv",sep=";", header=TRUE)
head(mortdata)
colnames(mortdata)
dim(mortdata)
is.data.frame(mortdata)
is.matrix(mortdata)
class(mortdata)

# Algumas Medidas Descritivas

summary(mortdata)

library("psych")
describe(mortdata)
head(describe(mortdata))


mortdata5=mortdata[c(2,5,14,26,28,34)]
head(mortdata5)
summary(mortdata5)


# Histogramas e Boxplots da UE27 e 5 Países

par(mfrow=c(2,3))
boxplot(mortdata[,2], main = "UE27", ylab = "Taxa de mortalidade infantil", col="darkmagenta")
boxplot(mortdata[,5], main = "Alemanha", ylab = "Taxa de mortalidade infantil", col= "yellow")
boxplot(mortdata[,14], main = "Espanha", ylab = "Taxa de mortalidade infantil", col= "red")
boxplot(mortdata[,26], main = "Holanda", ylab = "Taxa de mortalidade infantil", col= "orange")
boxplot(mortdata[,28], main = "Portugal", ylab = "Taxa de mortalidade infantil", col ="green")
boxplot(mortdata[,34], main = "Reino Unido", ylab = "Taxa de mortalidade infantil", col="white")

par(mfrow=c(2,3))
hist(mortdata[,2], main = "UE27", xlab = "Taxa de mortalidade infantil", col="darkmagenta")
hist(mortdata[,5], main = "Alemanha", xlab = "Taxa de mortalidade infantil", col= "yellow")
hist(mortdata[,14], main = "Espanha", xlab = "Taxa de mortalidade infantil", col= "red" )
hist(mortdata[,26], main = "Holanda", xlab = "Taxa de mortalidade infantil ",col= "orange")
hist(mortdata[,28],  main = "Portugal", xlab = "Taxa de mortalidade infantil", col ="green")
hist(mortdata[,34], main = "Reino Unido", xlab = "Taxa de mortalidade infantil", col="white")


## c)

# Gráfico para Comparar a UE27 e 5 Países em 1961 e 2018

dev.new()
matrix(c(mortdata[2,c(2,5,14,26,28,34)],mortdata[59,c(2,5,14,26,28,34)]),6,2)
matplot(matrix(c(mortdata[2,c(2,5,14,26,28,34)],mortdata[59,c(2,5,14,26,28,34)]),6,2),type="l",
        ylab="Taxa média de mortalidade infantil",xlab="UE27 e 5 Países", col=c("blue","green"),axes=FALSE)
legend("topleft",c("1961","2018"),pch = "--", col = c("blue", "green"), bty = "n")
axis(1,1:6,c("UE27","DE","ES","NL","PT","UK"))
axis(2,c(0,20,40,60,80,100))

## d)

# Algumas Medidas Amostrais relativas a 31 Países em 2018

mortdata[59,-c(1:4)] #Retira 4 colunas e ficam 31 colunas
apply(mortdata[59,-c(1:4)],1,mean) 
apply(mortdata[59,-1],1,median)
apply(mortdata[59,-1],1,var)
apply(mortdata[59,-1],1,sd)/apply(mortdata[59,-1],1,mean)
(apply(mortdata[59,-1],1,sd)/apply(mortdata[59,-1],1,mean))*100


## e)

# Análise da Evolução Temporal da Taxa de Mortalidade Infantil em Portugal

plot(mortdata[,1],mortdata$PT, main="Evolução da Mortalidade Infantil em Portugal",
     ylab="Taxa Média", xlab="Anos",col="red", pch=16)# type="l")
points(mortdata[,1],mortdata$UE27, col="blue", pch=16)
leg_cols <- c("red", "blue")
leg_sym <- c(16, 16)
leg_lab <- c("Portugal", "UE27")
legend(x = "topright", col = leg_cols, pch = leg_sym, legend = leg_lab, bty = "n")#bty="n" retira a "moldura" da legenda


## f)

# Entrada dos Dados (Taxa de Mortalidade Infantil e o PIB)


pib2018<-read.table("C:/Users/UserCarol/Dropbox/My PC (Carol)/Documents/IST_2022-23/R_PE_2022-23/Dados_PE/ex3f.dat", header=TRUE)$TaxaPIB

#Estudo da Associação Linear entre as Duas Variáveis


mortdata$PT
mortdata$PT[-c(1,60)] #Retira a informação do ano de 2019 para Portugal
plot(pib2018,mortdata$PT[-c(1,60)],xlab="PIB: Taxa de Crescimento Real",
     ylab="Taxa Média de Mortalidade Infantil (1961 a 2018)")
cor(pib2018,mortdata$PT[-c(1,60)])# Coeficiente de Correlação Linear de Pearson
```


a) médias, modas, medianas.


- quantil de 10%. tem 10% da amostra para trás.
- quantil da mediana. tem 50% atrás e 50% à frente.

Quantis dividem-se em quartis???

==summary()== - dá o primeiro quartil a mediana a média e o máximo.
==fivenum()== - mesma cena do de cima mas sem a indicação de o que é cada um.

==quantile(bicicletas, 0.68, tyle=2)==
==IQR(bicicletas)==
==stem(bicicletas)==

### Tipos de variáveis: quantitativas ou qualitativas.
Dentro das quantitativas podem ser contínuas ou discretas.

==boxplot()==

![[Pasted image 20230301125257.png]]

==dev.new== - dá reset.



# Para fazer o relatório:

Fazer em markdown.

Novo ficheiro em R_Markdown.
Exportar com o tipo de ficheiro.
Correr com Knit em cima à esquerda.