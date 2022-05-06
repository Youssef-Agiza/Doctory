const express = require("express")
const userRouter = require("./user")
const authRouter = require("./auth")
const recordRouter = require("./record")
const recordTypeRouter = require("./recordType")
const appointmentRouter = require("./appointment")

const AppRouter = express.Router()

AppRouter.use("/auth", authRouter)
AppRouter.use("/users", userRouter)
AppRouter.use("/records", recordRouter)
AppRouter.use("/recordTypes", recordTypeRouter)
AppRouter.use("/appointments", appointmentRouter)

module.exports = AppRouter
