import express from "express"
import * as userController from "../controllers/user"

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

export default userRouter
