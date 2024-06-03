const JankenTest = artifacts.require('JankenTest');
const { hand, jankenEvent, findEvent, sleep } = require('./helper');

contract('Janken', (accounts) => {
  let janken;
  const master = accounts[1];
  const host = accounts[2];
  const guest = accounts[3];

  before(async () => {
    janken = await JankenTest.new();
  });

  describe('call judge()', async () => {
    it('wins by first param', async () => {
      const result = await janken._judge(hand.guu, hand.choki, { from: host });
      assert.equal(result, 0, 'result must be 0');
    });

    it('wins by second param', async () => {
      const result = await janken._judge(hand.guu, hand.paa, { from: host });
      assert.equal(result, 1, 'result must be 1');
    });

    it('draws', async () => {
      const result = await janken._judge(hand.guu, hand.guu, { from: host });
      assert.equal(result, 2, 'result must be 2');
    });

    it('invalid params', async () => {
      let err;
      try {
        const result = await janken._judge(hand.none, hand.guu, { from: host });
      } catch (e) {
        err = e;
      }
      assert.notEqual(err, undefined, 'err should not be undefined');
    });
  });
});
