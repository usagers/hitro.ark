export const isGeneratorFunction = (func: Object | undefined | null) => {
  return typeof func === 'function' && Object().toString.call(func) === '[object GeneratorFunction]'
}

export const isNormalFunction = (func: Object | undefined | null) => {
  return typeof func === 'function' && Object().toString.call(func) === '[object Function]'
}

export const isAsyncFunction = (func: Object | undefined | null) => {
  return typeof func === 'function' && Object().toString.call(func) === '[object AsyncFunction]'
}

export const isFunction = (func: Object | undefined | null) => {
  return isNormalFunction(func) || isAsyncFunction(func) || isGeneratorFunction(func)
}

