
np.comp.2f<-function(x,nombre.variables,variables.factor,coerce=T,dunn=F,...){
  if(coerce==T){
    for(i in seq_along(variables.factor)){
      x[,variables.factor[i]]<-as.factor(x[,variables.factor[i]])}
  }
  temp<-x[c(nombre.variables,variables.factor)]
  temp<-split(temp,temp[variables.factor[1]])
  rm(x)
  a<-c()
  for (i in 1:length(temp)){
    e<-temp[[i]]
    e[,variables.factor[2]]<-droplevels(e[,variables.factor[2]])
    if(length(levels(e[,variables.factor[2]]))>1){a[i]<-i}
    else{NA}
  }
  temp<-temp[a] # Lista con dataframes cuyo numero de niveles >1
  rm(a)
  if(dunn==F){
    lista<-list()
    pvalmatrix<-matrix(NA,2,length(nombre.variables))
    pvalmatrix[1,]<-nombre.variables
    for (i in 1:length(temp)){
    r<-1
    for(w in nombre.variables){
      a<-temp[[i]]
      l<-kruskal.test(a[,w]~a[,variables.factor[2]])
      pvalmatrix[2,r]<-l$p.value
      r<-r+1
    }
    lista[[i]]<-pvalmatrix
  }
  names(lista)<-names(temp)
  lista}
  else{
    library(FSA)
    lista.princ<-list()
    lista.sec<-list()
    for(i in 1:length(temp)){
      r<-1
      for(w in nombre.variables){
        a<-temp[[i]]
        q<-dunnTest(a[,w]~a[,variables.factor[2]],...)
        lista.sec[[r]]<-q$res
        r<-r+1
      }
      names(lista.sec)<-nombre.variables
      lista.princ[[i]]<-lista.sec}
    names(lista.princ)<-names(temp)
    lista.princ
  }
}
