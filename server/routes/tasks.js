const tasksRouter = require('express').Router();
const tasksController = require('../controllers/tasksController');
const verify = require ('./verifyUser');

tasksRouter.get('/', verify, tasksController.getAllTasks);
tasksRouter.post('/add', verify , tasksController.addTask );
tasksRouter.delete('/delete/:id', verify , tasksController.deleteTask );
tasksRouter.put('/modify/:id', verify , tasksController.modifyTask );

module.exports = tasksRouter;