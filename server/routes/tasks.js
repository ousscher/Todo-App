const tasksRouter = require('express').Router();
const tasksController = require('../controllers/tasksController');
const verify = require ('./verifyUser');

tasksRouter.get('/', verify, tasksController.getAllTasks);
tasksRouter.post('/add', verify , tasksController.addTask );

module.exports = tasksRouter;