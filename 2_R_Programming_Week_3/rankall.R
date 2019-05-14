rankall <- function(outcome, num = "best") {
	## Read outcome data
	data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    fd   <- as.data.frame(cbind(data[, 2],   # hospital
                                data[, 7],   # state
                                data[, 11],  # heart attack
                                data[, 17],  # heart failure
                                data[, 23]),
                                stringsAsFactors = FALSE) # pneumonia
	colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

	## Check that num and outcome are valid
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
		stop('invalid outcome')
	}
    
    temp_state <- fd[,c("state","hospital",outcome)]
    temp_state[,outcome] <- as.numeric(temp_state[,outcome])
    temp_state <- temp_state[(!is.na(temp_state[ ,outcome])),]
    temp_state <- temp_state[order(temp_state[,outcome], temp_state[,"hospital"]),]
    splited <- split(temp_state,temp_state$state )

    if(is.numeric(num)){
        output <- lapply(splited, function(x, num){
            return(data.frame(x)[num,"hospital"])
        },num)
	}else if(!is.numeric(num)){
		if(num=="best"){
            output <- lapply(splited, function(x){
                return(data.frame(x)[1,"hospital"])
            })
		}else if(num=="worst"){
            output <- lapply(splited, function(x){
                return(data.frame(x)[nrow(x),"hospital"])
            })
		}else{
			stop('invalid number')
		}
	}
	
	## For each state, find the hospital of the given rank
	## Return a data frame with the hospital names and the
	## (abbreviated) state name
temp_state1 <- names(output)
temp_names <- as.character(output)
output1 <- as.data.frame(cbind(temp_state1, temp_names)) 
colnames(output1) <- c("state","hospital")
return(output1)
}