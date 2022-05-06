const handlerFactory = require("./factory")

const defaultFieldsSelect = {
  id: true,
  appointment_date: true,
  appointment_from: true,
  appointment_to: true,
  dr_national_id: true,
  patient_national_id: true,
  doctor: {
    select: {
      id: true,
      name: true,
      mname: true,
      lname: true,
      phone: true,
      email: true,
    },
  },
  patient: {
    select: {
      id: true,
      name: true,
      mname: true,
      lname: true,
      phone: true,
      email: true,
    },
  },
}

exports.getAllAppointments = handlerFactory.getAllDocuments({
  modelName: "appointment",
  resultsName: "appointments",
  defaultFieldsSelect,
})

exports.getAppointment = handlerFactory.getDocument({
  modelName: "appointment",
  resultName: "appointment",
  defaultFieldsSelect,
})

exports.createAppointment = handlerFactory.createDocument({
  modelName: "appointment",
  resultName: "appointment",
  insertFields: [
    "appointment_date",
    "appointment_from",
    "appointment_to",
    "dr_national_id",
    "patient_national_id",
  ],
  defaultFieldsSelect,
})

exports.updateAppointment = handlerFactory.updateDocument({
  modelName: "appointment",
  resultName: "appointment",
  updateFields: [
    "appointment_date",
    "appointment_from",
    "appointment_to",
    "dr_national_id",
    "patient_national_id",
  ],
  defaultFieldsSelect,
})

exports.deleteAppointment = handlerFactory.deleteDocuments({
  modelName: "appointment",
})
