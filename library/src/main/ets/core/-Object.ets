export const isNonEmptyObject = (obj: Object | undefined | null) => {
  return isObject(obj) && Object.keys(obj as Object).length > 0
}

export const isEmptyObject = (obj: Object | undefined | null) => {
  return isObject(obj) && Object.keys(obj as Object).length === 0
}

export const isObject = (obj: Object | undefined | null) => {
  return Object().toString.call(obj) === '[object Object]'
}

