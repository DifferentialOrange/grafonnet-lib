{
  new(
    title,
    datasource=null,
    calc='mean',
    description='',
    height=null,
    transparent=null,
    max=100,
    min=0,
    thresholds=null,
    gauge_title=null,
    unit='percent',
    values=false
  ):: {
    [if description != '' then 'description']: description,
    [if height != null then 'height']: height,
    [if transparent != null then 'transparent']: transparent,
    title: title,
    type: 'gauge',
    datasource: datasource,
    options: {
      fieldOptions: {
        calcs: [
          calc,
        ],
        defaults: {
          mappings: [],
          max: max,
          min: min,
          [if thresholds != null then 'thresholds']: thresholds,
          [if gauge_title != null then 'title']: gaugeTitle,
          unit: unit
        },
        values: values
      },
    },
    _nextTarget:: 0,
    addTarget(target):: self {
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
    },
  },

  threshold(
    color,
    value=null
  ):: {
    color: color,
    value: value
  }

}
