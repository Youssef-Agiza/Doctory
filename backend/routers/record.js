const express = require("express")
const recordController = require("../controllers/record")

const recordRouter = express.Router()

// routers for multiple
recordRouter
  .route("/")
  .get(recordController.getAllRecords)
  .post(recordController.createRecord)

// for a single id
recordRouter
  .route("/:id")
  .get(recordController.getRecord)
  .patch(recordController.updateRecord)
  .delete(recordController.deleteRecord)

module.exports = recordRouter
