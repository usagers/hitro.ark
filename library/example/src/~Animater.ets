import tsp from '../../Index'

const runner = tsp.debounce(() => console.log('Test debounce'), 3000)

const tester = async () => {
  await new Promise<void>(resolve => {
    setTimeout(() => {
      resolve()
      runner()
    }, 1000)
  })

  await new Promise<void>(resolve => {
    setTimeout(() => {
      resolve()
      runner()
    }, 1000)
  })

  await new Promise<void>(resolve => {
    setTimeout(() => {
      resolve()
      runner()
    }, 1000)
  })

  await new Promise<void>(resolve => {
    setTimeout(() => { resolve() }, 3500)
  })

  await new Promise<void>(resolve => {
    setTimeout(() => {
      resolve()
      runner()
    }, 1000)
  })

  await new Promise<void>(resolve => {
    setTimeout(() => {
      resolve()
      runner()
    }, 1000)
  })

  await new Promise<void>(resolve => {
    setTimeout(() => {
      resolve()
      runner()
    }, 1000)
  })
}

tester()