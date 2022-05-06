const AppError = require("./AppError")

const validateSchema = (schema) => (req, res, next) => {
  const result = schema.validate(req.body, {
    abortEarly: false,
    convert: true,
  })

  if (result.error) {
    return next(
      new AppError(
        result.error.details?.map((el) => el?.message || "").join(". ") || "",
        400
      )
    )
  }

  req.body = {
    ...req.body,
    ...result.value,
  }

  next()
}

module.exports = validateSchema
