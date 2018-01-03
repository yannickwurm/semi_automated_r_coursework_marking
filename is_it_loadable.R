directories <- c("question1")
files <- list()

for (directory in directories) {
    files[[directory]] <- list.files(path = directory,
                                     pattern = ".*R")

}


for (directory in directories) {
    for (file in unlist(files[directory])){
        print(paste("Trying", directory, file))
        try(source(file.path(directory, file)))
    }
}


