const express = require("express")
const Joi = require("joi")
const recordTypeController = require("../controllers/recordType")
const validateSchema = require("../utils/validateSchema")

const recordRouter = express.Router()

const schema = Joi.object({
  name: Joi.string().required().trim(),
  description: Joi.string(),
})

recordRouter
  .route("/")
  .get(recordTypeController.getAllRecordTypes)
  .post(validateSchema(schema), recordTypeController.createRecordType)
  .delete(recordTypeController.deleteRecordType)

recordRouter
  .route("/:id")
  .get(recordTypeController.getRecordType)
  .patch(validateSchema(schema), recordTypeController.updateRecordType)

module.exports = recordRouter
