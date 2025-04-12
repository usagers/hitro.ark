import { isFinite } from './-Number'
import { toFinite } from './-Number'
import { isObject } from './-Object'
import { isFunction } from './-Function'
import { isNullable } from './~Nullable'

export const debounce = (func: Function, wait: number, options: DebounceOptions = {}) => {
  let result: Object | undefined | null
  let timerId: Object | undefined | null
  let lastArgs: Object | undefined | null
  let lastInvokeTime: number = 0
  let lastCallTime: number = 0


  if (!isFunction(func)) {
    throw new TypeError('#<func> is not a function')
  }

  if (!isObject(options)) {
    options = {}
  }

  wait = Math.max(toFinite(wait), 0)

  const leading = options.leading === true
  const trailing = options.trailing !== false
  const maxWait = isFinite(options.maxWait) && Math.max(options.maxWait as number, wait)

  const debounced = (...rest: Array<Object | undefined | null>): Object | null | undefined => {
    const time = Date.now()
    const isInvoking = shouldInvoke(time)

    lastCallTime = time
    lastArgs = rest

    if (isInvoking && isNullable(timerId)) {
      return leadingEdge(lastCallTime)
    }

    if (isInvoking && (maxWait as number | false) !== false) {
      clearTimeout(timerId as number)
      timerId = setTimeout(timerExpired, remainingWait(time))
      return invokeFunc(lastCallTime)
    }

    if (isNullable(timerId)) {
      timerId = setTimeout(timerExpired, wait)
    }

    return result
  }

  const trailingEdge = (time: number): Object | undefined | null => {
    timerId = undefined

    if (trailing && lastArgs) {
      return invokeFunc(time)
    }

    lastArgs = undefined

    return result
  }

  const leadingEdge = (time: number): Object | undefined | null => {
    if (leading) {
      return invokeFunc(time)
    }

    timerId = setTimeout(timerExpired, wait)

    lastInvokeTime = time

    return result
  }

  const timerExpired = (): Object | undefined | null => {
    const time = Date.now()

    if (shouldInvoke(time)) {
      return trailingEdge(time)
    }

    timerId = setTimeout(timerExpired, remainingWait(time))

    return
  }

  const remainingWait = (time: number): number => {
    const timeSinceLastCall = time - lastCallTime
    const timeSinceLastInvoke = time - lastInvokeTime
    const remainingCallTime = Math.max(wait - timeSinceLastCall, 0)
    const remainingInvokeTime = Math.max(+(maxWait as number) - timeSinceLastInvoke, 0)
    return (maxWait as number | false) === false ? remainingCallTime : Math.min(remainingCallTime, remainingInvokeTime)
  }

  const shouldInvoke = (time: number): boolean => {
    const timeSinceLastCall = time - lastCallTime
    const timeSinceLastInvoke = time - lastInvokeTime

    return (
      lastCallTime === 0 ||
        timeSinceLastCall < 0 ||
        timeSinceLastCall >= wait ||
        ((maxWait as number | false) !== false && timeSinceLastInvoke >= maxWait)
    )
  }

  const invokeFunc = (time: number) => {
    const args = lastArgs
    lastInvokeTime = time
    lastArgs = undefined
    result = func(args)
    return result
  }

  const cancel = () => {
    if (!isNullable(timerId)) {
      clearTimeout(timerId as number)
    }

    lastCallTime = lastInvokeTime = 0
    lastArgs = timerId = undefined
  }

  const flush = () => {
    return isNullable(timerId) ? result : trailingEdge(Date.now())
  }

  debounced.cancel = cancel
  debounced.flush = flush

  return debounced
}

export const throttle = (func: Function, wait: number, options: ThrottleOptions = {}) => {
  const leading = !isObject(options) || options.leading !== false
  const trailing = !isObject(options) || options.trailing !== false

  if (!isFunction(func)) {
    throw new TypeError('#<func> is not a function')
  }

  const  throttled = debounce(func, wait, {
    trailing: trailing,
    leading: leading,
    maxWait: wait,
  })

  return throttled
}

export interface ThrottleOptions extends Omit<DebounceOptions, 'maxWait'> {}

export interface DebounceOptions {
  trailing?: boolean;
  leading?: boolean;
  maxWait?: number;
}
