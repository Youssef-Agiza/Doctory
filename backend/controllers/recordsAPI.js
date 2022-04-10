const Joi = require('joi');

const express = require('express');
const app = express();
const  prisma = require('..models');

//const bodyparser
app.use(express.json());


// get all records
exports.getAllRecords = async (req, res, next) => {

    try {

        const records = await prisma.record.findMany({
            include: {record_type: true},
        });
        res.status(200).json(records);

    } catch (error) {
        next(error);
    }

};


// get a specific patient records
exports.getRecord = async (req, res, next) => {

    try {

        const {id} = req.params.id;
        const record = await prisma.record.findUnique({
            where: {
                id: Number(id)
            },
            include: {
                record_type: true
            }
        })
        res.status(200).json(record);

    } catch (error) {
        next(error);
    }

};

// POST
// create new record
exports.createRecord = async (req, res, next) => {

    const result = validateRecord(req.body);

    if(result.error)
    {
        res.status(400).send(result.error.details[0].message);
        return;
    }

    try {

        const record = await prisma.record.create({
            data: req.body
        });
        res.status(200).json(record);
        
    } catch (error) {
        next(error);
    }
};



// PUT
// update existing record
exports.updateRecord = async (req, res, next) => {

    const result = validateRecord(req.body);

    if(result.error)
    {
        res.status(400).send(result.error.details[0].message);
        return;
    }

   try {

    const {id} = req.params.id;
    const record = await prisma.record.update({
        where: {
            id: Number(id)
        },
        data: req.body
    })
    res.status(200).json(record);

} catch (error) {
    next(error);
}

};


// DELETE
exports.deleteRecord = async (req, res, next) => {

    try {

        const {id} = req.params.id;
        const deletedRecord = await prisma.record.delete({
            where: {
                id: Number(id)
            }
        })
        res.status(200).json(deletedRecord);

    } catch (error) {
        next(error);
    }
  
 };

 function validateRecord(Record)
 {   
     const schema = Joi.object({
         // put them all
         date: Joi.date().iso(),
         description: Joi.string().required(),
         appointments_id: Joi.number().integer().positive().min(1).required(),
         record_type_id: Joi.number().integer().positive().min(1).required(),
 
     });
 
     return schema.validate(Record, schema);
 }
 