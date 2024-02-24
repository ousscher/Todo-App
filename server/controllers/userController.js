const User = require ('../models/User'); 
const {authValidation} = require('../validation');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');


const singUp = async (req , res)=>{
    const {error} = authValidation(req.body);
    if (error) return res.status(400).send({"message" : error.details[0].message});
    const usernameExist = await User.findOne({username:req.body.username}); 
    if (usernameExist) return res.status(400).send({"message":"Username already exists"});

    //hash passwords
    const salt = await bcrypt.genSalt(10); 
    const hashPassword = await bcrypt.hash(req.body.password , salt);
    const user = new User({
        username:req.body.username, 
        password:hashPassword,
    })
    try{
        const savedUser = await user.save();
        return res.send({"user":savedUser._id});

    }catch(e){
        res.status(400).send(e);
    }
}

const singIn = async (req, res)=>{
    const {error} = authValidation(req.body);
    console.log(req.body.username); 
    console.log(req.body.password); 
    if (error) return res.status(400).send({'message': error.details[0].message});   
    const user = await User.findOne({username:req.body.username}); 
    if (!user) return res.status(400).send({"message":"Username  doesn't exist"});
    //PASSWORD is correct
    const validPass = await bcrypt.compare(req.body.password, user.password);
    if (!validPass) return res.status(400).send({"message" : "Password wrong, try again"})
    // return res.status(200).send({"token" : "here we pass the token"});

    const token = jwt.sign({_id:user._id} ,process.env.SECRET_KEY); 
    res.header('auth-token', token ).send({"token" : token});

}



module.exports = {singIn , singUp};