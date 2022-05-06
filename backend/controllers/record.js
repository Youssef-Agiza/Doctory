const handlerFactory = require("./factory")

const defaultFieldsSelect = {
  id: true,
  date: true,
  description: true,
  appointment_id: true,
  record_type_id: true,
  appointment: {
    select: {
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
    },
  },
  record_type: true,
  record_files: true,
}

// get all records
exports.getAllRecords = handlerFactory.getAllDocuments({
  modelName: "record",
  resultsName: "records",
  defaultFieldsSelect,
})

// get a specific patient records
exports.getRecord = handlerFactory.getDocument({
  modelName: "record",
  resultName: "record",
  defaultFieldsSelect,
})

// POST
// create new record
exports.createRecord = handlerFactory.createDocument({
  modelName: "record",
  resultName: "record",
  insertFields: ["date", "description", "appointment_id", "record_type_id"],
  defaultFieldsSelect,
})

// PATCH
// update existing record
exports.updateRecord = handlerFactory.updateDocument({
  modelName: "record",
  resultName: "record",
  updateFields: ["date", "description", "appointment_id", "record_type_id"],
  defaultFieldsSelect,
})

// DELETE
exports.deleteRecord = handlerFactory.deleteDocuments({
  modelName: "record",
})
