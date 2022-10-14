const adminMiddleware = async(req, res, next)=>{
    if(req.user.role="Developer"){
        next();
    }else{
        res.sendStatus(401);
    }
}

module.exports = adminMiddleware;