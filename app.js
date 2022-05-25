const express = require('express') 
const app = express() 
const cors = require('cors');
const { Producer } = require('sqs-producer');
const port = 3000
const AWS = require("aws-sdk");
const credentials = new AWS.SharedIniFileCredentials({
  profile: "default",
});
const sns = new AWS.SNS({ credentials: credentials, region: "ap-northeast-2" });

app.use(express.json());

app.get('/', (req, res) => res.send('Hello june World!')) 

app.post('/api/post/june', (req, res) => {
  let params = {
    Message: `${req.body}`,
    // https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/SQS.html#sendMessage-property
    TopicArn: "arn:aws:sns:ap-northeast-2:523139768306:test"
  };
  sns.publish(params, function (err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
    return res.status(200).send({ message: `${req.body}` });
  });
})
  
app.listen(port, () => {
  console.log(`서버가 ${port}번에서 작동중입니다.`);
});