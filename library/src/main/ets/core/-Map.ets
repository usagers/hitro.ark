export const isNonEmptyMap = (map: Object | undefined | null) => {
  return isMap(map) && (map as Map<Object, Object>).size > 0
}

export const isEmptyMap = (map: Object | undefined | null) => {
  return isMap(map) && (map as Map<Object, Object>).size === 0
}

export const isMap = (map: Object | undefined | null) => {
  return Object().toString.call(map) === '[object Map]'
}

