rankhospital <- function(state, outcome, num = "best") {
	## Read outcome data
	data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    fd   <- as.data.frame(cbind(data[, 2],   # hospital
                                data[, 7],   # state
                                data[, 11],  # heart attack
                                data[, 17],  # heart failure
                                data[, 23]),
                                stringsAsFactors = FALSE) # pneumonia
	colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

	## Check that state and outcome are valid
	if(!state %in% fd[,"state"]){
		stop('invalid state')
	}else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
		stop('invalid outcome')
	}else if(is.numeric(num)){
		temp_state <- fd[which(fd[,"state"]==state),] #get state hospital according to index #state matrix
		temp_state1 <- temp_state[,c("hospital",outcome)]
		temp_state1 <- temp_state1[order(temp_state1[,"hospital"]),]
		temp_state1[,outcome] <- as.numeric(temp_state1[,outcome])
		temp_state1 <- temp_state1[(!is.na(temp_state1[ ,outcome])),]
		temp_state1 <- temp_state1[order(temp_state1[,outcome]),]
		output <- temp_state1[num,"hospital"]
	}else if(!is.numeric(num)){
		temp_state <- fd[which(fd[,"state"]==state),] #get state hospital according to index #state matrix
		temp_state1 <- temp_state[,c("hospital",outcome)]
		temp_state1 <- temp_state1[order(temp_state1[,"hospital"]),]
		temp_state1[,outcome] <- as.numeric(temp_state1[,outcome])
		temp_state1 <- temp_state1[(!is.na(temp_state1[ ,outcome])),]
		temp_state1 <- temp_state1[order(temp_state1[,outcome]),]
		if(num=="best"){
			output <- temp_state1[1,"hospital"]
		}
		else if(num=="worst"){
			output <- temp_state1[nrow(temp_state1),"hospital"]
		}
		else{
			stop('invalid number')
		}
	}
	## Return hospital name in that state with the given rank
return(output)
	## 30-day death rate
}