export const isNonEmptyString = (str: Object | undefined | null) => {
  return isString(str) && !!(str as string).trim()
}

export const isEmptyString = (str: Object | undefined | null) => {
  return isString(str) && !(str as string).trim()
}

export const isString = (str: Object | undefined | null) => {
  return Object().toString.call(str) === '[object String]'
}

