# Libraries and options ####
suppressPackageStartupMessages(c(
  library(stringr),
  library(tm)
))

load("nfreq.f2.RData")
load("nfreq.f3.RData")
load("nfreq.f4.RData")
load("nfreq.f5.RData")

freq2$word1 <- word(freq2$word, 1)
freq2$word2 <- word(freq2$word, 2)

freq3$word1 <- word(freq3$word, 1)
freq3$word2 <- word(freq3$word, 2)
freq3$word3 <- word(freq3$word, 3)

freq4$word1 <- word(freq4$word, 1)
freq4$word2 <- word(freq4$word, 2)
freq4$word3 <- word(freq4$word, 3)
freq4$word4 <- word(freq4$word, 4)

freq5$word1 <- word(freq5$word, 1)
freq5$word2 <- word(freq5$word, 2)
freq5$word3 <- word(freq5$word, 3)
freq5$word4 <- word(freq5$word, 4)
freq5$word5 <- word(freq5$word, 5)

## Function predicting the next word
predictWord <- function(the_word) {


  word_add <- stripWhitespace(removeNumbers(removePunctuation(tolower(the_word),preserve_intra_word_dashes = TRUE)))
  
  the_word <- strsplit(word_add, " ")[[1]]
  
  n <- length(the_word)
  
  if (n == 0 ) { as.character(head("it",1))}
  else if (n == 1) {the_word <- as.character(tail(the_word,1)); functionBigram(the_word)}
  else if (n == 2) {the_word <- as.character(tail(the_word,2)); functionTrigram(the_word)}
  else if (n == 3) {the_word <- as.character(tail(the_word,3)); functionQuadgram(the_word)}
  else if (n >= 4) {the_word <- as.character(tail(the_word,4)); functionFivegram(the_word)}
}

 functionBigram <- function(the_word) {
  if (identical(character(0),as.character(head(freq2[freq2$word1 == the_word[1], "word2"], 1)))) {
    as.character(head("it",1))
  }
  else {
    as.character(head(freq2[freq2$word1 == the_word[1],"word2"], 1))
  }
}
 functionTrigram <- function(the_word) {
 
  if (identical(character(0),as.character(head(freq3[freq3$word1 == the_word[1]
                                                  & freq3$word2 == the_word[2], "word3"], 1)))) {
    as.character(predictWord(the_word[2]))
  }
  else {
    as.character(head(freq3[freq3$word1 == the_word[1]
                         & freq3$word2 == the_word[2], "word3"], 1))
  }
}
 functionQuadgram <- function(the_word) {
  
  if (identical(character(0),as.character(head(freq4[freq4$word1 == the_word[1]
                                                  & freq4$word2 == the_word[2]
                                                  & freq4$word3 == the_word[3], "word4"], 1)))) {
    as.character(predictWord(paste(the_word[2],the_word[3],sep=" ")))
  }
  else {
    as.character(head(freq4[freq4$word1 == the_word[1]
                         & freq4$word2 == the_word[2]
                         & freq4$word3 == the_word[3], "word4"], 1))
  }
}
functionFivegram <- function(the_word) {
  # testing print(the_word)
  if (identical(character(0),as.character(head(freq5[freq5$word1 == the_word[1]
                                                            & freq5$word2 == the_word[2]
                                                            & freq5$word3 == the_word[3]
                                                            & freq5$word4 == the_word[4], "word5"], 1)))) {
    as.character(predictWord(paste(the_word[2],the_word[3],the_word[4],sep=" ")))
  }
  else {
    as.character(head(freq5[freq5$word1 == the_word[1]
                                   & freq5$word2 == the_word[2]
                                   & freq5$word3 == the_word[3]
                                   & freq5$word4 == the_word[4], "word5"], 1))
  }
}
