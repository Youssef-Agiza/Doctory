const handlerFactory = require("./factory")

exports.getAllRecordTypes = handlerFactory.getAllDocuments({
  modelName: "record_type",
  resultsName: "record_types",
})

exports.getRecordType = handlerFactory.getDocument({
  modelName: "record_type",
  resultName: "record_type",
})

exports.createRecordType = handlerFactory.createDocument({
  modelName: "record_type",
  resultName: "record_type",
  insertFields: ["name", "description"],
})

exports.updateRecordType = handlerFactory.updateDocument({
  modelName: "record_type",
  resultName: "record_type",
  updateFields: ["name", "description"],
})

exports.deleteRecordType = handlerFactory.deleteDocuments({
  modelName: "record_type",
})
