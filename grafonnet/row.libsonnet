{
  new(
    title='Row',
    #collapsed=false,
    datasource=null,
    # repeat=null,
    width=24,
    height=1,
  ):: {
    collapsed: false,
    panels: [],
    datasource: datasource,
    title: title,
    type: 'row',
    gridPos: {
        h: height,
        w: width
    }
    # addPanels(panels):: self {
    #   panels+: panels,
    # },
    # addPanel(panel, gridPos={}):: self {
    #   panels+: [panel { gridPos: gridPos }],
    # },
  },
}
