const Redis = require('redis');

async function createRedisClient () {
  const client = Redis.createClient(6379,'teamb.ovtthy.ng.0001.apn2.cache.amazonaws.com');

  client.on('connect', () => console.log('Connected to REDIS!'));
  client.on('error', (err) => console.log('Error connecting to REDIS: ', err));

  await client.connect();

  return client;
}

module.exports = createRedisClient();