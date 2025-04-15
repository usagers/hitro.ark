export interface IPromiser<T = Object | undefined | null> extends Promise<T> {
  reject: (reason?: Object | undefined | null) => void
  resolve: (value: T | PromiseLike<T>) => void
  promise: Promise<T>;
  completed: boolean;
  fulfilled: boolean;
  rejected: boolean;
  pending: boolean;
}

export const toPromise = <T = Object | undefined | null>(...rest: Array<Object | undefined | null>) => {
  let reject = (_?: Object | null) => {}

  let resolve = (_: T | PromiseLike<T>) => {}

  const wrapper = (promise: Promise<T>) => {
    promise = promise.then(value => {
      promiser.pending = false
      promiser.rejected = false
      promiser.fulfilled = true
      promiser.completed = true
      return value
    })

    promise = promise.catch((reason: Object) => {
      promiser.pending = false
      promiser.rejected = true
      promiser.fulfilled = false
      promiser.completed = true
      return Promise.reject(reason)
    })

    return promise as IPromiser<T>
  }

  const promise = new Promise<T>((r1, r2) => {
    resolve = r1
    reject = r2
  })

  const promiser = wrapper(Promise.race([...rest, promise]) as Promise<T>)

  promiser.completed = false
  promiser.fulfilled = false
  promiser.rejected = false
  promiser.pending = true

  promiser.promise = promiser
  promiser.resolve = resolve
  promiser.reject = reject

  return promiser
}

export const isPromise = (val: Object | undefined | null) => {
  return Object().toString.call(val) === '[object Promise]'
}
