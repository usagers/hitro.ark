import { toPromise } from '../../Index'

const promiser = toPromise(new Promise<void>((_, reject) => { setTimeout(reject, 3000) }))

promiser.then((_?: Object | null) => { console.log('success') })

promiser.catch((_: Object) => { console.log('failure') })

promiser.resolve(true)
