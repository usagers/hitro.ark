export const isWeakMap = (map: Object | undefined | null) => {
  return Object().toString.call(map) === '[object WeakMap]'
}
