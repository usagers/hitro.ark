export const isWeakSet = (set?: Object | undefined | null) => {
  return Object().toString.call(set) === '[object WeakSet]'
}

