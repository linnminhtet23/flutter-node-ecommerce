const User = require("../models/users");
const bycrypt = require("bcrypt");
const generateToken = require("../utils/generateToken");

require("dotenv").config();

const getAllUsers = async (req, res) => {
  try {
    const userList = await User.find().sort("createdAt");
    const count = await User.count();

    res.status(200).json({ success: true, data: userList, total: count });
  } catch (error) {
    res.status(500).json({ success: false });
  }
};

const getUser = async (req, res) => {
  const { id } = req.params;
  try {
    const user = await User.findById(id);
    res.status(200).send(user);
  } catch (error) {
    res.status(500).json({ success: false });
  }
};

const getUserProfile = async (req, res) => {
  console.log(req.user);
  // res.send({
  //   _id:req.user._id,
  //   name: req.user.name,
  //   email: req.user.email,
  //   phone: req.user.phone,
  //   street: req.user.street,
  //   apartment: req.user.apartment,
  //   zip: req.user.zip,
  //   city: req.user.city,
  //   country: req.user.country,
  // });
};

const userSignUp = async (req, res) => {
  const {
    name,
    email,
    password,
    phone,
  } = req.body;

  try {
    const hashedPassword = await bycrypt.hash(password, 10);
    let user = new User({
      name,
      email,
      phone,
      password: hashedPassword,
     
    });
    user = await user.save();
    res.send(user);
  } catch (error) {
    res.sendStatus(500);
  }
};

const userSignIn = async (req, res) => {
  const user = await User.findOne({ email: req.body.email });
  try {
    if (user) {
      const samePassword = bycrypt.compareSync(
        req.body.password,
        user.password
      );
      if (samePassword) {
        const token = await generateToken(user);
        res.status(200).send({ name: user.name, token: token });
      } else {
        res.status(401).send("Wrong Email and Password");
      }
    } else {
      res.status(401).send("Wrong Email and Password");
    }
  } catch (error) {
    // console.log(error);
    res.sendStatus(500);
  }
};

const userSignOut = async (req, res) => {
  try {
    req.user.tokens = req.user.tokens.filter((data) => {
      return data.token !== req.token;
    });

    await req.user.save();
    res.send("Logout finished");
  } catch (error) {
    res.sendStatus(500);
  }
};

module.exports = {
  getAllUsers,
  getUser,
  getUserProfile,
  userSignUp,
  userSignIn,
  userSignOut
};
