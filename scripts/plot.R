# setwd(/path/to/temporales/scripts)

require(ggplot2)
violations <- read.csv("../datos/violations.csv")
violations$TOTAL_VIOL_CNT <- violations$h2a_violtn_cnt + violations$h2b_violtn_cnt

get_year_total <- function(year)
{
  year_data <- subset(violations, year.filed == year)
  total <- sum(year_data$TOTAL_VIOL_CNT)
  return(data.frame(year, total))
}

years <- 2002:2012
totals_by_year <- do.call(rbind, lapply(years, get_year_total))
png("../img/chart.png", width=700)
dodgewidth <- position_dodge(width=0.9)
p <- ggplot(data=totals_by_year, aes(year, total))
p + theme_bw() + geom_bar(stat="identity", fill="#750d0d") +
  labs(x="Año", y="Total de violaciones", title="Violaciones de H2A y H2B por año (2002-2012)") +
  geom_text(color="black", aes(y=total+300, label=total), size=3)
dev.off()
