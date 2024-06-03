const DebugMsg = artifacts.require('DebugMsg');

contract('DebugMsg', (accounts) => {
  let debugMsg;
  const targetAddress = '0xC6b6586B59D9405ad169D2C1Bf43C3BF49ef56E5';
  //const master = accounts[1];

  before(async () => {
    debugMsg = await DebugMsg.new();
  });

  describe('call updateCounter()', async () => {
    it('happy path', async () => {
      const result = await debugMsg.updateCounter(1, { from: targetAddress });
      assert.equal(result, 1, 'result must be 1');
    });
  });

  describe('call returnParam()', async () => {
    it('happy path', async () => {
      const result = await debugMsg.returnParam(1, { from: targetAddress });
      assert.equal(result, 1, 'result must be 1');
    });
  });

  describe('call getByte32Beacon()', async () => {
    it('happy path', async () => {
      const result = await debugMsg.getByte32Beacon({ from: targetAddress });
      console.log(result);
      assert.equal(
        result,
        '0xa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50',
        'result must be 1'
      );
    });
  });

  describe('call getByte32Logic()', async () => {
    it('happy path', async () => {
      const result = await debugMsg.getByte32Logic({
        from: targetAddress,
      });
      console.log(result);
      assert.equal(
        result,
        '0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc',
        'result must be 1'
      );
    });
  });

  describe('call getByte32Admin()', async () => {
    it('happy path', async () => {
      const result = await debugMsg.getByte32Admin({
        from: targetAddress,
      });
      console.log(result);
      assert.equal(
        result,
        '0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103',
        'result must be 1'
      );
    });
  });
});
