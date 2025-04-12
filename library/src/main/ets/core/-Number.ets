export const isNaN = (num: Object | undefined | null) => {
  return Number.isNaN(num)
}

export const isNumber = (num: Object | undefined | null) => {
  return Object().toString.call(num) === '[object Number]'
}

export const isFinite = (num: Object | undefined | null) => {
  return isNumber(num) && Number.isFinite(num)
}

export const isDecimal = (num: Object | undefined | null) => {
  return isFinite(num) && !Number.isInteger(num)
}

export const isInteger = (num: Object | undefined | null) => {
  return isFinite(num) && Number.isInteger(num)
}

export const isInfinity = (num: Object | undefined | null) => {
  return num === Infinity || num === -Infinity
}

export const isSafeNumber = (num: Object | undefined | null) => {
  return isFinite(num) && (num as number) <= Number.MAX_SAFE_INTEGER && (num as number) >= Number.MIN_SAFE_INTEGER
}

export const isSafeInteger = (num: Object | undefined | null) => {
  return isFinite(num) && Number.isSafeInteger(num)
}

export const toSafeInteger = (num?: Object | undefined | null, _?: never) => {
  if (+Number(num) >= Number.MAX_SAFE_INTEGER) {
    return Number.MAX_SAFE_INTEGER
  }

  if (+Number(num) <= Number.MIN_SAFE_INTEGER) {
    return Number.MIN_SAFE_INTEGER
  }

  if (isInteger(+Number(num))) {
    return +Number(num)
  }

  if (+Number(num) > 0) {
    return Math.floor(+Number(num))
  }

  if (+Number(num) < 0) {
    return Math.ceil(+Number(num))
  }

  return 0
}

export const toSafeNumber = (num?: Object | undefined | null, _?: never) => {
  if (+Number(num) >= Number.MAX_SAFE_INTEGER) {
    return Number.MAX_SAFE_INTEGER
  }

  if (+Number(num) <= Number.MIN_SAFE_INTEGER) {
    return Number.MIN_SAFE_INTEGER
  }

  if (isFinite(+Number(num))) {
    return +Number(num)
  }

  return 0
}

export const toInteger = (num?: Object | undefined | null, _?: never) => {
  if (isInteger(+Number(num))) {
    return +Number(num)
  }

  if (isFinite(+Number(num))) {
    return +Number(num) > 0 ? Math.floor(+Number(num)) : Math.ceil(+Number(num))
  }

  return 0
}

export const toFinite = (num?: Object | undefined | null, lie = NaN) => {
  if (isFinite(+Number(num)) && isInteger(+Number(num))) {
    return +Number(num)
  }

  if (isFinite(+Number(num)) && !isNaN(lie)) {
    return +Number(toFixed(+Number(num), lie))
  }

  if (isFinite(+Number(num))) {
    return +Number(num)
  }

  return 0
}

export const toNumber = (num?: Object | undefined | null, lie = NaN) => {
  if (isNumber(+Number(num)) && isInteger(+Number(num))) {
    return +Number(num)
  }

  if (isNumber(+Number(num)) && !isNaN(lie)) {
    return +Number(toFixed(+Number(num), lie))
  }

  if (isNumber(+Number(num))) {
    return +Number(num)
  }

  return 0
}

export const toFixed = (num?: Object | undefined | null, lie = NaN) => {
  if (+Number(num) === Infinity) {
    return 'Infinity'
  }

  if (+Number(num) === -Infinity) {
    return '-Infinity'
  }

  num = +Number(num)
  lie = lie >= 0 ? lie : NaN
  lie = isSafeInteger(lie) ? lie : NaN

  if (isFinite(num) && !isNaN(lie)) {
    const pow = Math.pow(10, lie)
    const data = Math.round(pow * Number(num))
    const number = String(data / pow)

    if (isDecimal(+Number(number))) {
      return number.split('.')[0] + '.' + number.split('.')[1].padEnd(lie, '0')
    }

    if (isInteger(+Number(number))) {
      return number + '.' + ''.padEnd(lie, '0')
    }
  }

  if (isFinite(num) && isNaN(lie)) {
    return num + ''
  }

  return ''
}

