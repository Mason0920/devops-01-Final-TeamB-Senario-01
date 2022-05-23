const express = require('express') 
const app = express() 
const cors = require('cors');
const port = 3000 
const read = require('body-parser/lib/read');
const mysql = require('mysql') 
const writeDB = require('./db/MasterConnection');
const readDB = require('./db/SlaveConnection');


app.use(
  cors({
    origin: true,
    credentials: true
  })
);

app.get('/', (req, res) => res.send('Hello june World!')) 

app.get('/api/get/june', function(req, res){
    res.status(200).json({
      "message" : "call get api june"
    });
  });
  
app.post('/api/post/june', function(req, res){

    res.status(200).json({
      "message" : "call post api june"
    });
  });
  

app.listen(port, () => {
  console.log(`서버가 ${port}번에서 작동중입니다.`);
});