export const isNonEmptySet = (set: Object | undefined | null) => {
  return isSet(set) && (set as Set<Object>).size > 0
}

export const isEmptySet = (set: Object | undefined | null) => {
  return isSet(set) && (set as Set<Object>).size === 0
}

export const isSet = (set: Object | undefined | null) => {
  return Object().toString.call(set) === '[object Set]'
}


