export const isNonEmptyArray = (arr: Object | undefined | null) => {
  return isArray(arr) && (arr as Array<Object>).length > 0
}

export const isEmptyArray = (arr: Object | undefined | null) => {
  return isArray(arr) && (arr as Array<Object>).length === 0
}

export const isArray = (arr: Object | undefined | null) => {
  return Array.isArray(arr)
}
