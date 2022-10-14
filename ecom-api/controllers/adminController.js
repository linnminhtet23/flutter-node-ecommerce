const Admin = require("../models/admins");
const bycrypt = require("bcrypt");
const generateToken = require("../utils/generateToken");

require("dotenv").config();

const getAllAdmins = async (req, res) => {
  try {
    const adminList = await Admin.find().sort("createdAt");
    const count = await Admin.count();

    res.status(200).json({ success: true, data: adminList, total: count });
  } catch (error) {
    res.status(500).json({ success: false });
  }
};

const getAdmin = async (req, res) => {
  const { id } = req.params;
  try {
    const admin = await Admin.findById(id);
    res.status(200).send(admin);
  } catch (error) {
    res.status(500).json({ success: false });
  }
};

const getUserProfile = async (req, res) => {
  res.send({
    _id: req.user._id,
    name: req.user.name,
    email: req.user.email,
    phone: req.user.phone,
    street: req.user.street,
    apartment: req.user.apartment,
    zip: req.user.zip,
    city: req.user.city,
    country,
  });
};

const adminCreate = async (req, res) => {
  let { name, role, password } = req.body;

  try {
    const generatedPassword = Math.random() * 10000000;
    password = generatedPassword;
    const hashedPassword = await bycrypt.hash(password, 10);
    let user = new Admin({
      name,
      role,
      plainPassword:plainPassword,
      password: hashedPassword,
    });
    user = await user.save();
    res.send(user);
  } catch (error) {
    console.log(error);
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
  getAllAdmins,
  getAdmin,
  getUserProfile,
  adminCreate,
  userSignIn,
  userSignOut,
};
