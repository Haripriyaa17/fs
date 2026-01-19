src/to_inventory.js
npx create-react-app .
npm install axios

import React, { useState, useEffect } from "react";
import axios from "axios";

function Display_Inventory() {
  const [res, setRes] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const response = await axios.get("http://localhost:8000");
      setRes(response.data);
    };
    fetchData();
  }, []);

  return (
    <div>
      <h1>Inventory Management</h1>
      <table border="1">
        <thead>
          <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
          </tr>
        </thead>
        <tbody>
          {res.map((item) => (
            <tr key={item.id}>
              <td>{item.id}</td>
              <td>{item.prodname}</td>
              <td>{item.qty}</td>
              <td>{item.price}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function AddInventory() {
  const [id, setId] = useState("");
  const [prodname, setProdname] = useState("");
  const [qty, setQty] = useState("");
  const [price, setPrice] = useState("");

  const SubmitEvent = async () => {
    const data = {
      id: id,
      prodname: prodname,
      qty: qty,
      price: price
    };

    await axios.post("http://localhost:8000/add", data);
    alert("Product Added");
  };

  return (
    <div>
      <h1>Add Inventory</h1>

      <table border="1">
        <tbody>
          <tr>
            <td>ID</td>
            <td>
              <input type="number" value={id} onChange={(e) => setId(e.target.value)} />
            </td>
          </tr>

          <tr>
            <td>Product Name</td>
            <td>
              <input type="text" value={prodname} onChange={(e) => setProdname(e.target.value)} />
            </td>
          </tr>

          <tr>
            <td>Quantity</td>
            <td>
              <input type="number" value={qty} onChange={(e) => setQty(e.target.value)} />
            </td>
          </tr>

          <tr>
            <td>Price</td>
            <td>
              <input type="number" value={price} onChange={(e) => setPrice(e.target.value)} />
            </td>
          </tr>

          <tr>
            <td colSpan="2">
              <button onClick={SubmitEvent}>Add</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}

export { Display_Inventory, AddInventory };

backend/myInventory.js
npm init -y
npm install express cors
node myInventory.js

const express =  require('express');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());       // to support JSON-encoded bodies
const inventory=[
    {id:1, prodname: "prod1", qty: 12, price:12},
    {id:2, prodname: "prod2", qty: 1, price:13},
    {id:3, prodname: "prod3", qty: 10, price:14},
    {id:4, prodname: "prod4", qty: 19, price:16},
];

app.get('/',(req, res, err)=>{
    res.json(inventory);
})

app.post('/add',(req,res)=>{
    console.log(req.body.id);
    const invent = {id: req.body.id,
        prodname: req.body.prodname,
        qty: req.body.qty,
        price: req.body.price};
        inventory.push(invent)
        res.json(inventory);
});

app.listen(8000,()=>{
    console.log('express is working at http://localhost:8000');
})

