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
    thresholds=[],
    gauge_title=null,
    unit='percent',
    values=false,
    labels=false,
    markers=true,
    orientation='auto',
    threshold_mode='absolute'
  ):: {
    [if description != '' then 'description']: description,
    [if height != null then 'height']: height,
    [if transparent != null then 'transparent']: transparent,
    title: title,
    type: 'gauge',
    pluginVersion: '6.6.0',
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
          thresholds: {
            mode: threshold_mode,
            steps: thresholds,
          },
          title: gauge_title,
          unit: unit
        },
        overrides: [],
        values: values,
      },
      orientation: orientation,
      showThresholdLabels: labels,
      showThresholdMarkers: markers,
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
