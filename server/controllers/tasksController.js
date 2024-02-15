const jwt = require('jsonwebtoken');   
const Task = require('../models/Task');

const addTask = (req, res)=>{
    const [bearer, token] = req.headers['authorization'].split(' ');
    const userId = jwt.verify(token, process.env.SECRET_KEY)._id;

    const task = new Task({
        title: req.body.title,
        content: req.body.content,
        userId: userId
    });

    task.save()
    .then(data=>{
        res.json({"message": "Task added successfully!"});
    })
    .catch(err=>{
        res.json({message: err});
    });
};

const getAllTasks = async (req, res)=>{
    const [bearer, token] = req.headers['authorization'].split(' ');
    const userId = jwt.verify(token, process.env.SECRET_KEY)._id;
    const tasks = await Task.find({userId: userId});
    res.send({tasks: tasks});
};

const deleteTask = async (req, res) => {
    const [bearer, token] = req.headers['authorization'].split(' ');
    const userId = jwt.verify(token, process.env.SECRET_KEY)._id;
    const taskId = req.params.id;

    try {
        const task = await Task.findOne({ _id: taskId, userId: userId });

        if (!task) {
            return res.status(404).json({ message: 'Task not found' });
        }

        await Task.deleteOne({ _id: taskId, userId: userId });

        res.json({ message: 'Task deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

module.exports = { getAllTasks, addTask, deleteTask };



module.exports = {getAllTasks , addTask};