{
  new(
    title='Row',
    #collapsed=false,
    datasource=null
    # repeat=null,
  ):: {
    collapsed: false,
    panels: [],
    datasource: datasource,
    title: title,
    type: 'row',
    # addPanels(panels):: self {
    #   panels+: panels,
    # },
    # addPanel(panel, gridPos={}):: self {
    #   panels+: [panel { gridPos: gridPos }],
    # },
  },
}
