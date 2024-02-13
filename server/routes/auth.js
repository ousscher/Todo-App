const authRouter = require('express').Router();
const User = require('../models/User'); 
const userController = require ('../controllers/userController')

authRouter.post("/register" , userController.singUp);

authRouter.post("/login" ,  userController.singIn);

module.exports = authRouter;