### Funktioner för att skapa en befolkningspyramid.

forbered_bef_pyramid_func <- function(data, Kon_kolumn, Varde_kolumn){
  
  # Ser till att det både går att skicka namnet på en kolumn med eller utan "". Svårt att förstå hur det fungerar.
  Kon_kolumn <- ensym(Kon_kolumn)     # Konvertera Kon_kolumn till symbol.
  Varde_kolumn <- ensym(Varde_kolumn) # Konvertera Varde_kolumn till symbol.
  
  # Returnera 'data' med en ny kolumn 'multiplikator'.
  data %>%
    group_by(!!Kon_kolumn) %>%         # Gruppera efter Kon_kolumn (konvertera till symbol med !!).
    mutate(
      multiplikator = cur_group_id(),  # Skapa 'multiplikator' baserat på gruppens id vilket skapas alfabetiskt. 1 - Kvinnor, 2 - Män.
      multiplikator = case_when(
        multiplikator == 2 ~ 1,        # Justera multiplikatorer vid behov. Män får värdet 1 och kvinnor får värdet -1.
        multiplikator == 1 ~ -1
      )
    ) %>%
    ungroup() %>%                   # Kom ihåg att alltid avgruppera!
    mutate(!!Varde_kolumn := !!Varde_kolumn * multiplikator)  # Uppdatera Varde_kolumn med multiplikatorn.
}