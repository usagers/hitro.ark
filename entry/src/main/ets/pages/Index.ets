import tsp from '@hitro/ark'

@Entry
@Component
struct Index {
  async runArkTest() {
    const count = tsp.signal(1)
    const compute = tsp.computed(() => count.value)

    tsp.effect(() => { console.log(`${compute.value}`) })

    setTimeout(() => count.value = count.value + 3, 3000)
    setTimeout(() => count.value = count.value + 2, 2000)
    setTimeout(() => count.value = count.value + 1, 1000)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Row()
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .height(56)
          .width(56)

        Row() {
          Text('@hitro/ark')
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .fontColor(0x303133)
            .fontSize(18)
            .maxLines(1)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .layoutWeight(1)
        .height(56)

        Row()
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .height(56)
          .width(56)
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Text('Click: Test @hitro.ark')
            .onClick(() => this.runArkTest())
            .padding({ top: 4, left: 8, right: 8, bottom: 4 })
            .fontWeight(FontWeight.Medium)
            .fontColor(0x606266)
            .fontSize(16)
        }
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 100, left: 30, right: 30, bottom: 30 })
      .margin({ top: 56 })
      .width('100%')
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .backgroundColor(Color.White)
    .height('100%')
    .width('100%')
  }
}

