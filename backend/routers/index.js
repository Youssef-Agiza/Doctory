const express = require("express")
const userRouter = require("./user")
const authRouter = require("./auth")

const AppRouter = express.Router()

AppRouter.use("/auth", authRouter)
AppRouter.use("/users", userRouter)

module.exports = AppRouter
