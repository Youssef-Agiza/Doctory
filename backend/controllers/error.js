const sendDevError = (res, error) => {
  res.status(error.statusCode).json({
    staus: error.status,
    message: error.message,
    error,
    stack: error.stack,
  })
}

const sendProdError = (res, error) => {
  if (error.isOperational) {
    res.status(error.statusCode).json({
      staus: error.status,
      message: error.message,
    })
  } else {
    res.status(500).json({
      staus: "error",
      message: "Something went wrong!",
    })
  }
}

exports.errorHandler = (error, req, res, next) => {
  error.statusCode = error.statusCode || 500
  error.status = error.status || "error"
  if (process.env.NODE_ENV === "development") {
    return sendDevError(res, error)
  } else {
    return sendProdError(res, error)
  }
}

exports.catchAsync = (fn) => {
  return (req, res, next) => fn(req, res, next).catch(next)
}
