const express = require('express') 
const app = express() 
const cors = require('cors');
const { Producer } = require('sqs-producer');
const port = 3000
const AWS = require("aws-sdk");
AWS.config.update({region: 'ap-northeast-2'});
const credentials = new AWS.SharedIniFileCredentials({
  profile: "mason",
});
var sqs = new AWS.SQS({credentials: credentials, apiVersion: '2012-11-05'});
var params = {
 DelaySeconds: 1,
 MessageBody: "reservation succeeded",
 QueueUrl: "https://sqs.ap-northeast-2.amazonaws.com/523139768306/EC2_SQS_ECS"
};

app.use(express.json());

app.get('/', (req, res) => res.send('Hello june World!')) 

app.post('/api/post/june', (req, res) => {
  sqs.sendMessage(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    console.log("Success", data);
    }
  })
  res.statusCode(200)
    .send("message accepted");
})
  
app.listen(port, () => {
  console.log(`서버가 ${port}번에서 작동중입니다.`);
});