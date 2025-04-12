import { isString } from './-String'

export const isRegExp = (reg: Object | undefined | null) => {
  return Object().toString.call(reg) === '[object RegExp]'
}

export const toRegExp = (reg: Object | undefined | null, flags?: string) => {
  if (isRegExp(reg)) {
    return new RegExp((reg as RegExp).source, flags ?? (reg as RegExp).flags)
  }

  if (isString(reg)) {
    return new RegExp(reg as string, flags)
  }

  return /(?:)/
}

