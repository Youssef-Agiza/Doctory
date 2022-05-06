const express = require("express")
const Joi = require("joi")
const recordController = require("../controllers/record")
const validateSchema = require("../utils/validateSchema")

const recordRouter = express.Router()

const schema = Joi.object({
  date: Joi.date().iso().required(),
  description: Joi.string(),
  appointment_id: Joi.number().integer().required(),
  record_type_id: Joi.number().integer().required(),
})

// routers for multiple
recordRouter
  .route("/")
  .get(recordController.getAllRecords)
  .post(validateSchema(schema), recordController.createRecord)
  .delete(recordController.deleteRecord)

// for a single id
recordRouter
  .route("/:id")
  .get(recordController.getRecord)
  .patch(validateSchema(schema), recordController.updateRecord)

module.exports = recordRouter
