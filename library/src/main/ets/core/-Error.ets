export const isReferenceError = (err: Object | undefined | null) => {
  try { return err instanceof ReferenceError } catch { return false }
}

export const isSyntaxError = (err: Object | undefined | null) => {
  try { return err instanceof SyntaxError } catch { return false }
}

export const isRangeError = (err: Object | undefined | null) => {
  try { return err instanceof RangeError } catch { return false }
}

export const isEvalError = (err: Object | undefined | null) => {
  try { return err instanceof EvalError } catch { return false }
}

export const isTypeError = (err: Object | undefined | null) => {
  try { return err instanceof TypeError } catch { return false }
}

export const isURIError = (err: Object | undefined | null) => {
  try { return err instanceof URIError } catch { return false }
}

export const isError = (err: Object | undefined | null) => {
  try { return err instanceof Error } catch { return false }
}

