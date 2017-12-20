var DHFixedToken = artifacts.require('./DHFixedToken.sol')

contract('DH Fixed Token', accounts => {
  // Token owner
  var john_address = accounts[0]

  var jane_address = accounts[1]
  var dave_address = accounts[2]

  let instance

  // Test case
  // 1. Make sure the token supply is initialized correctly (to 1000)
  // 2. John calls transfer to send 100 token to Jane
  // 3. Check Jane' balance it should be 100
  // 4. Check John's balance it should be 900
  it('totalSupply() should be correct', async () => {
    instance = await DHFixedToken.deployed()
    let totalSupply = await instance.totalSupply.call()

    assert.equal(totalSupply.valueOf(), 1000, 'TotalSupply is NOT 1000')
  })

  // Test case
  // 1. John transfers 100 token
  // 2. Assert =>
  //           John balance = 1000 - 100 = 900
  //           Jane balance = 100
  it('transfer() should be correct', async () => {
    instance.transfer(jane_address, 100, { from: john_address })

    let jane_balance = await instance.balanceOf.call(jane_address)
    let john_balance = await instance.balanceOf.call(john_address)

    assert.equal(john_balance.valueOf(), 900, 'John balance is NOT 900')
    assert.equal(jane_balance.valueOf(), 100, 'Jane balance is NOT 100')
  })

  // Test case
  // 1. John approves() Jane for 50 tokens
  // 2. Assert =>
  //           Jane's allowance = 50
  it('approve() should be correct', async () => {
    instance.approve(jane_address, 50)

    let jane_allowance = await instance.allowance.call(
      john_address,
      jane_address
    )

    assert.equal(jane_allowance.valueOf(), 50, 'Jane allowance is NOT have 50')
  })

  // Test case
  // 1. Jane transferFrom() John 5 tokens to Dave
  // 2. Assert =>
  //           John balance = 1000 - 100 - 5 = 895
  //           Jane balance = 100
  //           Dave balance = 5
  //           Jane's allowance = 45
  it('transferForm() should be correct', async () => {
    let instance = await DHFixedToken.deployed()

    instance.transferFrom(john_address, dave_address, 5, {
      from: jane_address
    })

    let john_balance = await instance.balanceOf.call(john_address)
    let jane_balance = await instance.balanceOf.call(jane_address)
    let dave_balance = await instance.balanceOf.call(dave_address)
    let jane_allowance = await instance.allowance.call(
      john_address,
      jane_address
    )

    assert.equal(john_balance.valueOf(), 895, 'John balance is NOT 895')
    assert.equal(jane_balance.valueOf(), 100, 'Jane balance is NOT 100')
    assert.equal(dave_balance.valueOf(), 5, 'Dave balance is NOT 5')
    assert.equal(jane_allowance.valueOf(), 45, 'Jane allowance is NOT 45')
  })
})
