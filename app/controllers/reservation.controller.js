const Reservation = require("../models/reservation.model.js");
const createRedisClient = require("../models/connectRedis.js");
const { Producer } = require('sqs-producer');

// 새 객체 생성
exports.create = (req,res)=>{
    if(!req.body){
        res.status(404).send({
            message: "Invalid input"
        });
    };

    const reservation = new Reservation({
      departure: req.body.departure,
      destination: req.body.destination,
      date: req.body.date,
      user_name: req.body.user_name
    });
    
    // 데이터베이스에 저장
    Reservation.create(reservation, (err, data) =>{
        if(err){
            res.status(503).send({
                message:
                err.message || "Some errors occured while creating the Reservation."
            });
        };
    })

    redisClient.then((client) => { 
      // do something with the client
      client.set("Hello", "Real World").then(()=> { 
         // can do something here 
      });
    });
};

// exports.TOSQS = (req, res) => {
//   const producer = Producer.create({
//     queueUrl: 'https://sqs.ap-northeast-2.amazonaws.com/523139768306/EC2_SQS_ECS',
//     region: 'ap-northeast-2'
//   });
   
  
//   producer.send([{
//     id: 'id1',
//     body: 'Reservation : OK'
//   }]);
   
//   res.send('Resevation : Successed')
// }

// 전체 조회 
exports.findAll = (req,res)=>{
    Reservation.getAll((err, data) => {
        if (err)
          res.status(500).send({
            message:
              err.message || "Some error occurred while retrieving reservations."
          });
        else res.send(data);
      });
};

// id로 조회
exports.findOne = (req,res)=>{
    Reservation.findById(req.params.reservationId, (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Reservation with id ${req.params.reservationId}.`
            });
          } else {
            res.status(500).send({
              message: "Error retrieving Reservation with id " + req.params.reservationId
            });
          }
        } else res.send(data);
      });
};


 
 
