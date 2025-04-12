import tsp from '../../Index'

const map1 = new Map<Object, Object>([
  [Object({ name: 'No1' }), Object({ age: 18 })],
  [Object({ name: 'No12' }), Object({ age: 28 })]
])

const map2 = new Map<Object, Object>([
  [Object({ name: 'No1' }), Object({ age: 18 })],
  [Object({ name: 'No12' }), Object({ age: 28 })]
])

tsp.equal(map1, map2)
