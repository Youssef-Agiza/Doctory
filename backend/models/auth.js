const bcrypt = require("bcryptjs")
const prisma = require(".")

// compare between a hashed and non hashed user password
exports.isCorrectPassword = async (password = "__", hashedPassword = "_") => {
  return await bcrypt.compare(password, hashedPassword)
}

const hashUserPassword = async (password) => {
  return await bcrypt.hash(password, 12)
}

// middleware to hash password before signing up
prisma.$use(async (params, next) => {
  if (params.model === "user" && params.action === "create") {
    const hashedPassword = await hashUserPassword(params.args.data.password)
    params.args.data.password = hashedPassword
  }
  return next(params)
})

// middleware to hash password before resetting/changing password
prisma.$use(async (params, next) => {
  if (
    params.model === "user" &&
    params.action.startsWith("update") &&
    params.args.data.password
  ) {
    const hashedPassword = await hashUserPassword(params.args.data.password)
    if (params.args.where.passwordResetToken) {
      params.args.data.passwordResetToken = null
      params.args.data.passwordResetTokenExpiry = null
    }
    params.args.data.passwordChangedAt = new Date()
    params.args.data.password = hashedPassword
  }
  return next(params)
})
