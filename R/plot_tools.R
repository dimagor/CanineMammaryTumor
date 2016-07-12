#' Plot Boxplots using Ensemble Genes
#' @export
plotResultBoxPlots <- function(selectedgenes,
                               counts = CPMmatrices$zpatregressed,
                               info = samplesCanine,
                               nrows = NA){
  # "ENSCAFG00000030622" Example for testing
  if(is.data.frame(selectedgenes)) {
    selectedgenes <- selectedgenes$gene
  }
  if(length(selectedgenes)>16){
    selectedgenes <- selectedgenes[1:16]
    warning("Attempting to plot more than 16 may result in system slowdown. The first 16 genes will be shown.")
  }
  colnames(counts)[colnames(counts) == "9A1"] <- "9A"
  counts.selected = counts[which(rownames(counts) %in% selectedgenes),]
  counts.selected =t(counts.selected)
  df = melt(counts.selected,id.vars="rownames")
  colnames(df)=c("Qlabel","ID","value")
  if(length(selectedgenes)==1){
    df$Qlabel <- df$ID
    df$ID <- selectedgenes
  }
  df = merge(info,df,by="Qlabel")
  data(humanmapping)
  df <- left_join(df,Map_CanEns2HumSymb_unique,by=c("ID"="Can_Ens")) %>% mutate(Hum_Symb=ifelse(is.na(Hum_Symb),ID,Hum_Symb))
  df$Hist <- factor(df$Hist,levels=c("N","B","M"), labels=c("Normal","Adenoma","Carcinoma"))
  p<-ggplot(df,aes(factor(Hist),value,fill=Hist))+
    geom_boxplot(notch=FALSE)+
    scale_fill_manual(name="Histology",
                      values=c("green","blue","red"),
                      labels=c("Normal","Adenoma","Carcinoma")) +
    xlab("Histology") +
    ylab("Scaled, Patient-Regressed Expression") +
    theme_bw()
  if (is.na(nrows)) {
    p<-p+facet_wrap(~ Hum_Symb,scale="free_y")
  } else p<-p+facet_wrap(~ Hum_Symb,scale="free_y", nrow = nrows)

  return(p)
}


#' Plot Boxplots using Human Symbols
#'@export
plotSymbol <- function(symbols, ...) profileMetrics %>% filter(Hum_Symb%in% symbols) %>% .$gene %>% unique %>% plotResultBoxPlots(...)
