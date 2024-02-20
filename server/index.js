const express = require('express'); 
const authRouter = require('./routes/auth');
const postsRouter = require('./routes/tasks');
const app = express();
const mongoose = require('mongoose'); 
const dotenv = require('dotenv');   

dotenv.config();
//connect to td
mongoose.connect(process.env.DB_CONNECT)
.then(()=>{
    console.log("connected to the dataBase");
}).catch((e)=>{
    console.log(e);
}); 

//middleware
app.use(express.json());

app.use( (req, res, next)=>{
    console.log(req.method+"  "+req.url+"   "+req.body);
    next();
})
app.use('/api/auth/' ,authRouter );
app.use('/api/posts/',postsRouter );

app.listen(3000,'0.0.0.0', ()=>{
    console.log("running server on the port 3000");
}); 
