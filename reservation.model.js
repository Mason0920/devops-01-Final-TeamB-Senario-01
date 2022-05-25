const Reservation = require("../models/reservation.model.js");
exports.notification = (req, res) => {
  console.log(req.body);
  console.log("왔나");
  //sqs producer 함수
  const { Producer } = require('sqs-producer');

  const producer = Producer.create({
      queueUrl: 'https://sqs.ap-northeast-2.amazonaws.com/523139768306/EC2_SQS_ECS',
      region: 'ap-norheast-2',
      accessKeyId: 'AKIAXTTMPL7ZEUAIQGQH',
      secretAccessKey: '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'
    });
  
  producer.send(['hyhy', 'mssfakjsnkg2']);
  
}
// 새 객체 생성
exports.create = (req,res)=>{
    if(!req.body){
        res.status(404).send({
            message: "Invalid input"
        });
    };

    const reservation = new Reservation({
        email: req.body.email,
        name: req.body.name,
        active: req.body.active
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
};



exports.post = (req, res) => {
  this.create()
  this.notification()
  return "ok"
}

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

// id로 갱신
exports.update = (req,res)=>{
    // Validate Request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
  }

  Reservation.updateById(
    req.params.reservationId,
    new Reservation(req.body),
    (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Reservation with id ${req.params.reservationId}.`
          });
        } else {
          res.status(500).send({
            message: "Error updating Reservation with id " + req.params.reservationId
          });
        }
      } else res.send(data);
    }
  );
};

// id로 삭제
exports.delete = (req,res)=>{
    Reservation.remove(req.params.reservationId, (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Reservation with id ${req.params.reservationId}.`
            });
          } else {
            res.status(500).send({
              message: "Could not delete Reservation with id " + req.params.reeservationId
            });
          }
        } else res.send({ message: `Reservation has been deleted successfully!` });
      });
};

// 전체 삭제
exports.deleteAll = (req,res)=>{
    Reservation.removeAll((err, data) => {
        if (err)
          res.status(500).send({
            message:
              err.message || "Some error occurred while removing all reservations."
          });
        else res.send({ message: `All Reservations were deleted successfully!` });
      });
};
 
 
