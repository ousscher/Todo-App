const tasksRouter = require('express').Router();
const taskController = require('../controllers/tasksController');
const verify = require ('./verifyUser');

tasksRouter.get('/', verify, taskController)

module.exports = tasksRouter;