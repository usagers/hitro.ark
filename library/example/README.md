# Hitro.ark

Tool Script Provider for HarmonyOS (ArkTS)

<br/>

## Install

```shell
  ohpm install @hitro/ark
```

<br/>

## Usage

```typescript
  import tsp from '@hitro/ark'

  tsp.isNonEmptyArray([]) // false
  tsp.isEmptyArray([]) // true
  tsp.isArray([]) // true
```

```typescript
  import { isNonEmptyArray } from '@hitro/ark'
  import { isEmptyArray } from '@hitro/ark'
  import { isArray } from '@hitro/ark'
  
  isNonEmptyArray([]) // false
  isEmptyArray([]) // true
  isArray([]) // true
```

<br/>

## API

- Array
- Boolean
- Date
- Error
- Function
- Map
- Number
- Object
- Promise
- RegExp
- Set
- String
- WeakMap
- WeakSet
- Animater
- Formater
- Nullable
- Operater
- Signaler
- Uniquer

<br/>

## License

Apache License 2.0
