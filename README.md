*np.comp.2f()*

## Descripción y objetivo
Cuando los datos no son homocedásticos y las transformaciones no han logrado que se cumpla esta asunción, resulta inevitable recurrir a los test no paramétricos, como el Kruskal-Wallis (análogo al test ANOVA) y el test de Dunn (análogo al test de Tukey de comparaciones múltiples). Estos test, por lo menos en R, no permiten evaluar la interacción entre dos factores y una variable de tipo cuantitativa, lo que es un gran incoveniente e implicará escribir un par de líneas de código para poder conseguir el mismo resultado que con un ANOVA.

La función que he programado tiene por objeto hacer más fácil la evaluación de las interacciónes en los tests no paramétricos. Pero ojo, sólo en interacciones con DOS factores. Esta función realiza, para cada nivel del 1er factor especificado, el test de Kruskal-Wallis o el de Dunn para comparar cada una de las variables entre los diferentes niveles del 2º factor especificado.

## Argumentos de la función

- **x**: es el dataframe donde se almacenan las variables objeto de estudio.

- **nombre.variables**: el nombre de las n columnas correspondientes a las variables dependientes, que han de ser de tipo cuantitativo.
- **variables.factor**: el nombre de las dos columnas donde se encuentran las variables de tipo factor, que han de ser de tipo cualitativo o cuantitativo discreto. El orden en el que se pongan afectará a las comparaciones que se hagan (haz la prueba cambiando el orden y comparando el resultado).
- **coerce**: especifica si quieres que las columnas eespecificadas en el anterior argumento (*variables.factor*) se trasnformen a factor o no. Por defecto coerce=T
- **dunn**: indica si quieres que se realize el test de Dunn de comparaciones múltiples o no. En este último caso, sólo se realizaría el test de kruskal.wallis(). Por defecto, dunn=F.
- **...**: otros argumentos que se le puedan añadir a la función *dunnTest()* del paquete FSA.

## Observaciones 

Es necesario tener instalado el paquete FSA para poder realizar el test de Dunn

## Resultados

- Si se realiza un test de Kruskal-Wallis se obtiene una lista en la que el nombre de cada elemento se corresponde con cada uno de los niveles del primer factor especificado. Dentro de cada elemento aparece una matriz con el nombre de cada variable y el pvalue del test Kruskal-Wallis (variable respuesta ~ 2º factor).
- Por otro lado, si realizamos el test de Dunn se obtiene una lista en la que el nombre de cada elemento se corresponde con cada uno de los niveles del primer factor especificado. Dentro de cada elemento aparece una segunda lista, donde el nombre de cada elemento corresponde a cada una de las variables dependientes y cada elemento alberga la matriz de comparaciones de esa variable con los diferentes niveles de la segunda variable factor.

## Ejemplo

Copia y pega las siguientes líneas de código y observa cómo trabaja la función:
~~~
set.seed(666)
prueba<-data.frame(variable1=runif(16),
                   variable2=rnorm(16),
                   factor1=rep(c("a","b"),each=8),
                   factor2=c(rep(c("x","y","z"),4),rep("x",4)))


np.comp.2f(prueba,c("variable1","variable2"),
	c("factor1","factor2"),
	dunn=T,method="holm")
~~~

## Referencias

Ogle, D.H., P. Wheeler, and A. Dinno. 2019. FSA: Fisheries Stock Analysis. R package version 0.8.26, https://github.com/droglenc/FSA.

