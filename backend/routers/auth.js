const express = require("express")
const Joi = require("joi")
const authController = require("../controllers/auth")
const validateSchema = require("../utils/validateSchema")

const authRouter = express.Router()

const signupSchema = Joi.object({
  id: Joi.number().integer().required(),
  name: Joi.string().required().trim(),
  mname: Joi.string().required().trim(),
  lname: Joi.string().required().trim(),
  password: Joi.string().required(),
  phone: Joi.string().required(),
  email: Joi.string().optional().email(),
})

const loginSchema = Joi.object({
  id: Joi.number().integer().required(),
  password: Joi.string().required(),
})

authRouter.post("/signup", validateSchema(signupSchema), authController.signup)

authRouter.post("/login", validateSchema(loginSchema), authController.login)

module.exports = authRouter
