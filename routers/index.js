const express = require("express")
import userRouter from "./user"
import authRouter from "./auth"

const AppRouter = express.Router()

AppRouter.use("/", authRouter)
AppRouter.use("/users", userRouter)

module.exports = AppRouter
