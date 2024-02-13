const postsRouter = require('express').Router();
const verify = require ('./verifyUser');

postsRouter.use('/', verify, (req, res)=>{
    res.json({
        "posts":"some random secret data"
    })
})

module.exports = postsRouter;