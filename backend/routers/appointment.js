const express = require("express")
const Joi = require("joi")
const appointmentController = require("../controllers/appointment")
const validateSchema = require("../utils/validateSchema")

const appointmentRouter = express.Router()

const schema = Joi.object({
  appointment_date: Joi.date().iso().required(),
  appointment_from: Joi.date().iso().required(),
  appointment_to: Joi.date().iso().required(),
  dr_national_id: Joi.number().integer().required(),
  patient_national_id: Joi.number().integer().required(),
})

appointmentRouter
  .route("/")
  .get(appointmentController.getAllAppointments)
  .post(validateSchema(schema), appointmentController.createAppointment)
  .delete(appointmentController.deleteAppointment)

appointmentRouter
  .route("/:id")
  .get(appointmentController.getAppointment)
  .patch(validateSchema(schema), appointmentController.updateAppointment)

module.exports = appointmentRouter
