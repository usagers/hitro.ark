export const isNullable = (val: Object | undefined | null) => {
  return isUndef(val) || isNull(val)
}

export const isUndef = (val: Object | undefined | null) => {
  return Object().toString.call(val) === '[object Undefined]'
}

export const isNull = (val: Object | undefined | null) => {
  return Object().toString.call(val) === '[object Null]'
}
