const handlerFactory = require("./factory")

const defaultFieldsSelect = {
  id: true,
  name: true,
  mname: true,
  lname: true,
  phone: true,
  email: true,
  address: true,
  birthdate: true,
  role: true,
}

const excludedFieldsSelect = {
  password: false,
  passwordChangedAt: false,
  passwordResetToken: false,
  passwordResetTokenExpiry: false,
}

exports.getAllUsers = handlerFactory.getAllDocuments({
  modelName: "user",
  resultsName: "users",
  defaultFieldsSelect,
  excludedFieldsSelect,
})

exports.getUser = handlerFactory.getDocument({
  modelName: "user",
  resultName: "user",
  defaultFieldsSelect,
  excludedFieldsSelect,
})

exports.createUser = handlerFactory.createDocument({
  modelName: "user",
  resultName: "user",
  insertFields: ["id", "name", "mname", "lname", "phone", "password"],
  defaultFieldsSelect: {
    ...defaultFieldsSelect,
    ...excludedFieldsSelect,
  },
})

exports.updateUser = handlerFactory.updateDocument({
  modelName: "user",
  resultName: "user",
  updateFields: ["id", "name", "mname", "lname", "phone", "password"],
  defaultFieldsSelect: {
    ...defaultFieldsSelect,
    ...excludedFieldsSelect,
  },
})

exports.deleteUser = handlerFactory.deleteDocuments({
  modelName: "user",
})
