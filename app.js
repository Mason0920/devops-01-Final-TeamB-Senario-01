const express = require('express') 
const app = express() 
const cors = require('cors');
const { Producer } = require('sqs-producer');
const port = 3000
const bodyParser = require('body-parser')

const producer = Producer.create({
  queueUrl: 'https://sqs.ap-northeast-2.amazonaws.com/523139768306/EC2_SQS_ECS',
  region: 'ap-northeast-2'
});

app.use(bodyParser.json())
app.use(
  cors({
    origin: true,
    credentials: true
  })
);

app.get('/', (req, res) => res.send('Hello june World!')) 

app.post('/api/post/june', async function(req, res){
    console.log(req.body)
    await producer.send(JSON.stringify(req.body))
    res
      .status(200)
      .send('message accepted!')
  });
  
app.listen(port, () => {
  console.log(`서버가 ${port}번에서 작동중입니다.`);
});