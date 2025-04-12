export interface ReturnPromise<T = Object | undefined | null> extends Promise<T> {
  reject: (reason?: Object | undefined | null) => void
  resolve: (value: T | PromiseLike<T>) => void
  promise: Promise<T>
}

export const toPromise = <T = Object | undefined | null>(...rest: Array<Object | undefined | null>) => {
  let reject = (_?: Object | null) => {}
  let resolve = (_: T | PromiseLike<T>) => {}

  const promise = new Promise<T>((r1, r2) => {
    resolve = r1
    reject = r2
  })

  const promiser = Promise.race([...rest, promise]) as ReturnPromise<T>

  promiser.promise = promiser
  promiser.resolve = resolve
  promiser.reject = reject

  return promiser
}

export const isPromise = (val: Object | undefined | null) => {
  return Object().toString.call(val) === '[object Promise]'
}

