const adminMiddleware = async(req, res, next)=>{
    if(req.user&&req.user){
        next();
    }else{
        res.sendStatus(401);
    }
}

module.exports = adminMiddleware;