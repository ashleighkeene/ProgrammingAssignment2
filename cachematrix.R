## cachematrix efficiently calculates the inverse of a matrix
## by caching the original matrix and its inverse in a 
## separate environment so that R can simply grab the solution
## (the inverse matrix) from the cache rather than calculating
# it over and over again


## makeCacheMatrix caches a matrix and its inverse in an 
## environment outside the Global Environment and returns a 
## list of functions: set (matrix), get (matrix), setinverse,
## getinverse

makeCacheMatrix <- function(x = matrix()) {
        nr <- nrow(x)
        nc <- ncol(x)
        matinv <- matrix(data=NULL, nrow=nr, ncol=ncol)
        print(environment())
        evn <- environment()
        print(parent.env(evn))
        
        set    <- function(y = matrix()) {
                mat    <<- y
                matinv <<- matrix(data=NULL, nrow=nr, ncol=ncol)
        }
        get    <- function() mat
        setinv <- function(solve) matinv <<- solve
        getinv <- function() matinv
        getevn <- function() environment()
        list(set    = set, 
             get    = get,
             setinv = setinv,
             getinv = getinv,
             getevn = getevn)
}

## cashsolve calculates the inverse of the matrix stored in x

cacheSolve <- function(x, ...) {
        matinv <- x$getinv()
        if(!is.null(mat)) {
                message("getting cached data")
                return(mat)
        }
        data <- x$get()
        matinv <- solve(data, ...)
        x$setinv(matinv)
        matinv
}
