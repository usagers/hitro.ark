import { isSet } from './-Set'
import { isMap } from './-Map'
import { isDate } from './-Date'
import { isArray } from './-Array'
import { isObject } from './-Object'
import { isRegExp } from './-RegExp'
import { isString } from './-String'
import { isFinite } from './-Number'
import { isNumber } from './-Number'
import { toInteger } from './-Number'
import { isWeakMap } from './-WeakMap'
import { isNullable } from './~Nullable'

export type IDeep = boolean | number
export type IFilter = Array<string | number | RegExp>
export interface IEqualOptions { strict?: IFilter; include?: IFilter; exclude?: IFilter; deep?: IDeep; }
export interface ICloneOptions { omit?: IFilter; pick?: IFilter; cache?: WeakMap<object, Object | undefined | null>; deep?: IDeep; }

export const equal = (one: Object | undefined | null, two: Object | undefined | null, opts: IEqualOptions | IDeep = true): boolean => {
  if (one === two) {
    return true
  }

  if (check(one, two)) {
    return true
  }

  if (isSet(one) && isSet(two)) {
    const set1 = one as Set<Object>
    const set2 = two as Set<Object>
    return set1.size === set2.size && equal(Array.from(set1), Array.from(set2), opts)
  }

  if (isMap(one) && isMap(two)) {
    const map1 = one as Map<Object, Object>
    const map2 = two as Map<Object, Object>
    return map1.size === map2.size && equal(Array.from(map1), Array.from(map2), opts)
  }

  if (isNumber(one) && isNumber(two)) {
    return Math.abs(one as number - (two as number)) < Number.EPSILON
  }

  const cfg = opts as IEqualOptions
  const deep = isObject(opts) ? (opts as IEqualOptions).deep : opts as IDeep
  const level = isNullable(deep) || deep === true || deep === Infinity ? Infinity : toInteger(deep)
  const include = isObject(cfg) && isArray(cfg.include) ? (cfg.include as IFilter).filter(key => isRegExp(key) || isFinite(key) || isString(key)) : [/(?:)/]
  const exclude = isObject(cfg) && isArray(cfg.exclude) ? (cfg.exclude as IFilter).filter(key => isRegExp(key) || isFinite(key) || isString(key)) : []
  const strict = isObject(cfg) && isArray(cfg.strict) ? (cfg.strict as IFilter).filter(key => isRegExp(key) || isFinite(key) || isString(key)) : []

  if (!isNumber(level) || level < 1) {
    return false
  }

  if (isRegExp(one) && isRegExp(two)) {
    const reg1 = one as RegExp
    const reg2 = two as RegExp
    return reg1.source === reg2.source && reg1.flags === reg2.flags && reg1.lastIndex === reg2.lastIndex
  }

  if (isObject(one) && isObject(two)) {
    const obj1 = one as Record<string, Object>
    const obj2 = two as Record<string, Object>

    const oneKeys = Object.keys(obj1).filter(key => {
      const excluded = exclude.length > 0 && exclude.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const included = include.length === 0 || include.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      return !excluded && included
    })

    const twoKeys = Object.keys(obj2).filter(key => {
      const excluded = exclude.length > 0 && exclude.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const included = include.length === 0 || include.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      return !excluded && included
    })

    if (oneKeys.length !== twoKeys.length) {
      return false
    }

    for (const key of Object.keys(obj1)) {
      const val1 = obj1[key]
      const val2 = obj2[key]
      const deep = level - 1
      const stricted = strict.length > 0 && strict.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const excluded = exclude.length > 0 && exclude.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const included = include.length === 0 || include.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))

      if (excluded || !included) {
        continue
      }

      if (val1 === val2) {
        continue
      }

      if (stricted) {
        return false
      }

      if (deep < 1) {
        return false
      }

      const result = equal(val1, val2, {
        strict,
        include,
        exclude,
        deep,
      })

      if (!result) {
        return false
      }
    }

    return true
  }

  if (isArray(one) && isArray(two)) {
    const arr1 = one as Array<Object>
    const arr2 = two as Array<Object>

    const oneKeys = Object.keys(arr1).filter(key => {
      const excluded = exclude.length > 0 && exclude.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const included = include.length === 0 || include.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      return !excluded && included
    })

    const twoKeys = Object.keys(arr2).filter(key => {
      const excluded = exclude.length > 0 && exclude.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const included = include.length === 0 || include.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      return !excluded && included
    })

    if (oneKeys.length !== twoKeys.length) {
      return false
    }

    for (const key of arr1.keys()) {
      const val1 = arr1[key]
      const val2 = arr2[key]
      const deep = level - 1
      const stricted = strict.length > 0 && strict.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const excluded = exclude.length > 0 && exclude.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))
      const included = include.length === 0 || include.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))

      if (excluded || !included) {
        continue
      }

      if (val1 === val2) {
        continue
      }

      if (stricted) {
        return false
      }

      if (deep < 1) {
        return false
      }

      const result = equal(val1, val2, {
        strict,
        include,
        exclude,
        deep,
      })

      if (!result) {
        return false
      }
    }

    return true
  }

  if (isDate(one) && isDate(two)) {
    return check((one as Date).getTime(), (two as Date).getTime())
  }

  return false
}

export const merge = <T = Object | undefined | null>(val: T, ...rest: Array<Object | undefined | null>): T => {
  const state = rest.slice(-1)[0]
  const cache: WeakMap<Object, Object> = new WeakMap()
  const level = isNumber(state) && state !== Infinity ? Math.max(toInteger(state), 1) : (state !== false ? Infinity : 1)

  const taking = (val: Object | Array<Object>): Array<[string | number, Object]> => {
    return isObject(val) ? Object.entries(val) : Array.from((val as Array<Object>).entries())
  }

  const merging = (val: T, obj: T, level: number): void => {
    const refer = (isMap(val as Object) || isSet(val as Object) ? Array.from(val as Iterable<Object>) : val) as Record<string, Object | undefined> | Array<Object | undefined>
    const newly = (isMap(obj as Object) || isSet(obj as Object) ? Array.from(obj as Iterable<Object>) : obj) as Record<string, Object | undefined> | Array<Object | undefined>

    for (const arr of taking(newly as Object)) {
      const key = arr[0]
      const source = arr[1]

      if (level < 1) {
        refer[key] = source
        continue
      }

      const isCopySet = isSet(source)
      const isCopyMap = isMap(source)
      const isCopyDate = isDate(source)
      const isCopyArray = isArray(source)
      const isCopyObject = isObject(source)
      const isCopyRegExp = isRegExp(source)
      const isNotSameType = Object().toString.call(refer[key]) !== Object().toString.call(source)

      if (!isCopySet && !isCopyMap && !isCopyDate && !isCopyArray && !isCopyObject && !isCopyRegExp) {
        refer[key] = source
        continue
      }

      if (!cache.has(source)) {
        cache.set(source, clone(source, { deep: level, cache }))
      }

      if (isNotSameType) {
        refer[key] = cache.get(source)
        continue
      }

      merging(refer[key] as T, newly[key] as T, level - 1)
    }

    if (isMap(val as Object) || isSet(val as Object)) {
      (val as Map<Object, Object> | Set<Object>).clear()
    }

    if (isMap(val as Object)) {
      for (const arr of (refer as Array<[Object, Object]>)) {
        const key = arr[0]
        const source = arr[1];
        (val as Map<Object, Object>).set(key, source)
      }
    }

    if (isSet(val as Object)) {
      for (const source of (refer as Array<Object>)) {
        (val as Set<Object>).add(source)
      }
    }
  }

  if (isObject(val as Object) || isArray(val as Object)) {
    for (const obj of rest) {
      if (Object().toString.call(val) !== Object().toString.call(obj)) {
        continue
      }

      merging(val, obj as T, level - 1)
    }
  }

  if (isMap(val as Object) || isSet(val as Object)) {
    for (const obj of rest) {
      if (Object().toString.call(val) !== Object().toString.call(obj)) {
        continue
      }

      merging(val, obj as T, level - 1)
    }
  }

  return val
}

export const clone = <T = Object | undefined | null>(val: T, opts: ICloneOptions | IDeep = true): T => {
  const cfg = opts as ICloneOptions
  const deep = isObject(opts) ? cfg.deep : opts
  const cache = (isObject(opts) && isWeakMap(cfg.cache) ? cfg.cache : new WeakMap()) as WeakMap<Object, Object>
  const level = isNullable(deep) || deep === true || deep === Infinity ? Infinity : Math.max(toInteger(deep), 1)

  const omit = isObject(cfg) && isArray(cfg.omit) ? (cfg.omit as IFilter).filter(key => isRegExp(key) || isString(key) || isFinite(key)) : []
  const pick = isObject(cfg) && isArray(cfg.pick) ? (cfg.pick as IFilter).filter(key => isRegExp(key) || isString(key) || isFinite(key)) : []

  const cloning = (val: T, level: number): T => {
    const value: ESObject = isArray(val as Object) ? [] : {}

    for (const arr of taking(val as Object)) {
      const key = arr[0]
      const source = arr[1]

      if (pick.length > 0 && !pick.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))) {
        continue
      }

      if (omit.length > 0 && omit.some(k => isRegExp(k) ? (k as RegExp).test(String(key)) : String(k) === String(key))) {
        continue
      }

      let record: Object | undefined = source

      const isCopySet = isSet(source)
      const isCopyMap = isMap(source)
      const isCopyDate = isDate(source)
      const isCopyArray = isArray(source)
      const isCopyObject = isObject(source)
      const isCopyRegExp = isRegExp(source)

      if (!isCopySet && !isCopyMap && !isCopyDate && !isCopyArray && !isCopyObject && !isCopyRegExp) {
        if (isArray(value)) {
          (value as Array<Object>).push(record)
        }

        if (!isArray(value)) {
          (value as Record<string, Object>)[key] = record
        }

        continue
      }

      if (level > 1 && !cache.has(source)) {
        cache.set(source, clone(source, { omit, pick, cache, deep: level - 1 }))
      }

      if (level > 1 && cache.has(source)) {
        record = cache.get(source)
      }

      if (isArray(value)) {
        (value as Array<Object>).push(record!)
      }

      if (!isArray(value)) {
        (value as Record<string, Object>)[key] = record!
      }
    }

    return value as T
  }

  const taking = (val: Object | Array<Object>): Array<[string | number, Object]> => {
    return isObject(val) ? Object.entries(val) : Array.from((val as Array<Object>).entries())
  }

  if (!isNumber(level) || level < 1) {
    return val
  }

  if (isRegExp(val as Object)) {
    const flags = (val as RegExp).flags
    const source = (val as RegExp).source
    const regexp = new RegExp(source, flags)
    regexp.lastIndex = (val as RegExp).lastIndex
    return regexp as T
  }

  if (isObject(val as Object)) {
    return cloning(val, level)
  }

  if (isArray(val as Object)) {
    return cloning(val, level)
  }

  if (isDate(val as Object)) {
    return new Date((val as Date).getTime()) as T
  }

  if (isMap(val as Object)) {
    const maps = Array.from((val as Map<Object, Object>).entries())
    return new Map(cloning(maps as T, level) as Array<[Object, Object]>) as T
  }

  if (isSet(val as Object)) {
    const sets = Array.from((val as Set<Object>).values())
    return new Set(cloning(sets as T, level) as Array<[Object]>) as T
  }

  return val
}

export const check = (one: Object | undefined | null, two: Object | undefined | null) => {
  return one === two ? one !== 0 || (1 / (one as number) === 1 / (two as number)) : one !== one && two !== two;
}
