CREATE TABLE `reservations` (
    `reservationId` BINARY(16)  NOT NULL ,
    `departure` varchar(200)  NOT NULL ,
    `destination` varchar(200)  NOT NULL ,
    `date` DATE  NOT NULL ,
    `user_name` BINARY(16)  NOT NULL ,
    PRIMARY KEY (
        `reservationId`
    )
);

INSERT INTO reservations(reservationId, departure, destination, date, user_name) VALUES(UUID_TO_BIN(UUID()), '부산도너츠 공장', '부산카페', '2022-03-04', 'peachdo');

SELECT
    BIN_TO_UUID(reservationId) as reservationId
FROM reservations;