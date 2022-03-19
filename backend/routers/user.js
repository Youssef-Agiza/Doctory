const express = require("express")
const userController = require("../controllers/user")

const userRouter = express.Router()

userRouter
  .route("/")
  .get(userController.getAllUsers)
  .post(userController.createUser)
  .delete(userController.deleteUser)

userRouter
  .route("/:id")
  .get(userController.getUser)
  .patch(userController.updateUser)

module.exports = userRouter
