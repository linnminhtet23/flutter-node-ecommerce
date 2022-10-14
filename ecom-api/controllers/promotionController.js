const Promotions = require("../models/promotions");
const fs = require("fs");

const getAllItems = async (req, res) => {
  try {
    let filter = {};
    if (req.query.categories) {
      filter = { category: req.query.categories.split(",") };
    }
    const promotionItems = await Promotions.find(filter);
    const counts = await Promotions.count();
    res
      .status(200)
      .json({ success: true, data: promotionItems, total: counts });
  } catch (error) {
    res.status(500).json({ success: false });
  }
};

const getItem = async (req, res) => {
  try {
    const { id } = req.params;
    const item = await Promotions.findById(id);

    res.status(200).send(item);
  } catch (error) {
    res.status(500).json({ success: false });
  }
};

const createItem = async (req, res) => {
  const { name } = req.body;
  try {
    const file = req.file;
    if (!file) return res.status(400).send("No image in the request");

    // const fileName = file.filename;
    // const basePath = `${req.protocol}://${req.get("host")}/public/uploads/`;
    // console.log(req.protocol)
    // console.log(req.get("host"));
    const item = new Promotions({
      name,
      image: req.file.path,
    });

    await item.save();

    res.status(201).json({ success: true, data: item });
  } catch (error) {
    return res.status(500).send("promotion item cannot be created");
  }
};

const updateItem = async (req, res) => {
  try {
    const { id } = req.params;

    const file = req.file;
    // if (!file) return res.status(400).send("No image in the request");
    // const basePath = `${req.protocol}://${req.get("host")}`;

    const promotionItem = await Promotions.findById(id);
    req.body.image = req.file ? req.file.path : promotionItem.image;

    if (file) {
      fs.unlinkSync(promotionItem.image);
    }

    const promotionItems = await Promotions.findByIdAndUpdate(
      id,
      {
        ...req.body,
      },
      { new: true }
    );

    res.send(promotionItems);
  } catch (error) {
    return res.status(500).send("promotion item cannot be updated");
  }
};

const deletePromotionItem =async (req, res) => {
  try {
    const { id } = req.params;

    const deletedItem =await Promotions.findById(id);
    // console.log(deletedItem.image);
    fs.unlinkSync(deletedItem.image);

    Promotions.findByIdAndRemove(id).then((item) => {
      if (item) {
        return res
          .status(200)
          .json({ success: true, message: "item is deleted!" });
      } else {
        return res
          .status(404)
          .json({ success: false, message: "item not found!" });
      }
    });
  } catch (error) {
    // console.log(error);
    return res.status(500).json({ success: false, error: error });
  }
};

module.exports = {
  getAllItems,
  getItem,
  createItem,
  updateItem,
  deletePromotionItem
};
