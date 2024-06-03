const hand = {
  guu: 0,
  choki: 1,
  paa: 2,
  none: 3,
};

const decodeEvent = {
  GameCreated: 'GameCreated',
  GameReady: 'GameReady',
  GameDone: 'GameDone',
  GameCanceled: 'GameCanceled',
  GameInfo: 'GameInfo',
};

const findEvent = (logs, eventName) => {
  if (!logs) {
    return false;
  }
  let result = undefined;
  logs.forEach((elem, index) => {
    if (elem.event == eventName) {
      result = elem.args;
      return;
    }
  });
  return result;
};

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

module.exports = {
  hand,
  jankenEvent,
  findEvent,
  sleep,
};
