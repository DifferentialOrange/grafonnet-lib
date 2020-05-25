{
  /**
   * @name row.new
   */
  new(
    title='Dashboard Row',
    width=24,
    height=1,
    collapse=false,
    repeat=null,
    showTitle=null,
    titleSize='h6'
  ):: {
    collapse: collapse,
    collapsed: collapse,
    panels: [],
    repeat: repeat,
    repeatIteration: null,
    repeatRowId: null,
    showTitle:
      if showTitle != null then
        showTitle
      else
        title != 'Dashboard Row',
    title: title,
    type: 'row',
    titleSize: titleSize,
    gridPos: {
        h: height,
        w: width
    },
    addPanels(panels):: self {
      panels+: panels,
    },
    addPanel(panel, gridPos={}):: self {
      panels+: [panel { gridPos: gridPos }],
    },
  },
}
