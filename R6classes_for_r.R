DynamicValue <- R6::R6Class("DynamicValue", list(
  value = NULL,
  on_update = NULL,
  
  get = function() self$value,
  
  set = function(value) {
    self$value <- value
    if (!is.null(self$on_update)) 
      self$on_update(value)
    invisible(self)
  },
  
  onUpdate = function(on_update) {
    self$on_update <- on_update
    invisible(self)
  }
))


test <- DynamicValue$new()
test$set(1)
test$get()
test$set(2)
test$get()
