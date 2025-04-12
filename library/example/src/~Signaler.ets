import tsp from '../../Index'

const count = tsp.signal(1)
const compute = tsp.computed(() => count.value)

tsp.effect(() => { console.log(`${compute.value}`) })

setTimeout(() => count.value++, 3000)
setTimeout(() => count.value++, 2000)
setTimeout(() => count.value++, 1000)