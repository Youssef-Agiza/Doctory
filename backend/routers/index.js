const express = require("express")
const userRouter = require("./user")
const authRouter = require("./auth")
const recordRouter = require("./record")

const AppRouter = express.Router()

AppRouter.use("/auth", authRouter)
AppRouter.use("/users", userRouter)
AppRouter.use("/record", recordRouter)

module.exports = AppRouter
