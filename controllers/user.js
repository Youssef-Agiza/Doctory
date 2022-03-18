import * as handlerFactory from "./factory"

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

export const getAllUsers = handlerFactory.getAllDocuments({
  modelName: "user",
  resultsName: "users",
  defaultFieldsSelect,
  excludedFieldsSelect,
})

export const getUser = handlerFactory.getDocument({
  modelName: "user",
  resultName: "user",
  defaultFieldsSelect,
  excludedFieldsSelect,
})

export const createUser = handlerFactory.createDocument({
  modelName: "user",
  resultName: "user",
  insertFields: ["id", "name", "mname", "lname", "phone", "role", "password"],
  defaultFieldsSelect: {
    ...defaultFieldsSelect,
    ...excludedFieldsSelect,
  },
})

export const updateUser = handlerFactory.updateDocument({
  modelName: "user",
  resultName: "user",
  updateFields: ["id", "name", "mname", "lname", "phone", "role", "password"],
  defaultFieldsSelect: {
    ...defaultFieldsSelect,
    ...excludedFieldsSelect,
  },
})

export const deleteUser = handlerFactory.deleteDocuments({
  modelName: "user",
})
