import { AppError, catchAsync } from "../utils/errorFactory"
import prisma from "../models"

export const getAllDocuments = ({
  modelName,
  resultsName,
  defaultFieldsSelect,
  excludedFieldsSelect,
}) =>
  catchAsync(async (req, res, next) => {
    const docs = await prisma[modelName].findMany({
      select: { ...defaultFieldsSelect, ...excludedFieldsSelect },
    })

    res.status(200).json({
      status: "success",
      results: docs.length,
      data: {
        [resultsName]: docs,
      },
    })
  })

export const getDocument = ({
  modelName,
  resultName,
  populateOptions,
  defaultFieldsSelect,
  excludedFieldsSelect,
}) =>
  catchAsync(async (req, res, next) => {
    try {
      const doc = await prisma[modelName].findFirst({
        where: { id: +req.params.id },
        select: { ...defaultFieldsSelect, ...excludedFieldsSelect },
        rejectOnNotFound: true,
      })
      res.status(200).json({
        status: "success",
        data: {
          [resultName]: doc,
        },
      })
    } catch (err) {
      return next(new AppError("record is not found", 404))
    }
  })

export const createDocument = ({
  modelName,
  resultName,
  insertFields,
  defaultFieldsSelect,
}) =>
  catchAsync(async (req, res, next) => {
    const newDoc = await prisma[modelName].create({
      data: insertFields.reduce(
        (acc, field) =>
          Object.assign(
            acc,
            req.body[field] ? { [field]: req.body[field] } : {}
          ),
        {}
      ),
      ...(defaultFieldsSelect ? { select: defaultFieldsSelect } : {}),
    })
    res.status(201).json({
      status: "success",
      data: {
        [resultName]: newDoc,
      },
    })
  })

export const updateDocument = ({
  modelName,
  resultName,
  updateFields,
  defaultFieldsSelect,
}) =>
  catchAsync(async (req, res, next) => {
    try {
      const newDoc = await prisma[modelName].update({
        where: { id: +req.params.id },
        data: updateFields.reduce(
          (acc, field) =>
            Object.assign(
              acc,
              req.body[field] ? { [field]: req.body[field] } : {}
            ),
          {}
        ),
        ...(defaultFieldsSelect ? { select: defaultFieldsSelect } : {}),
      })
      res.status(200).json({
        status: "success",
        data: {
          [resultName]: newDoc,
        },
      })
    } catch (err) {
      if (err.code === "P2025")
        return next(new AppError("record is not found", 404))
      else throw err
    }
  })

export const deleteDocuments = ({ modelName }) =>
  catchAsync(async (req, res, next) => {
    try {
      const deletedDocs = await prisma[modelName].deleteMany({
        where: {
          id: {
            in: req.body.ids,
          },
        },
      })
      if (deletedDocs.count === 0)
        return next(new AppError("record is not found", 404))
      res.status(204).json({
        status: "success",
      })
    } catch (err) {
      if (err.code === "P2004")
        return next(
          new AppError(
            "this record can't be deleted due to db constraints",
            405
          )
        )
      else throw err
    }
  })
