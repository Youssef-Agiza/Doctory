const express = require("express")
const authController = require("../controllers/auth")

const authRouter = express.Router()

authRouter.post("/signup", authController.signup)

authRouter.post("/login", authController.login)

module.exports = authRouter