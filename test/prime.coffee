prime = require 'effing/prime'
{ assert } = require 'chai'

describe "prime", ->
  it "returns first or after when there's no both", ->
    fn = prime
      first: -> 10
      after: -> 20
    assert fn() == 10
    assert fn() == 20
    assert fn() == 20

  it "returns both when it exists", ->
    fn = prime
      first: -> 10
      after: -> 20
      both: -> 30
    assert fn() == 30
    assert fn() == 30
    assert fn() == 30

  it "returns beforeBoth if it's the only thing specified", ->
    fn = prime
      beforeBoth: -> 5
    assert fn() == 5
    assert fn() == 5
    assert fn() == 5

  it "only runs the first argument once", ->
    x = 0
    fn = prime first: -> x++
    fn()
    fn()
    fn()
    assert x == 1

  it "only runs the after argument after the first invocation", ->
    x = 0
    fn = prime after: -> x++
    fn()
    assert x == 0
    fn()
    assert x == 1
    fn()
    assert x == 2

  it "preserves context", ->
    obj =
      foo: 10

    fn = prime
      first: -> @foo + 1
      after: -> @foo + 2

    assert fn.call(obj) == 11
    assert fn.call(obj) == 12
