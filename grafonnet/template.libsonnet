{
  new(
    name,
    datasource,
    query,
    label=null,
    allValues=null,
    tagValuesQuery='',
    current=null,
    hide='',
    regex='',
    refresh='never',
    includeAll=false,
    multi=false,
    sort=0,
  )::
    {
      allValue: allValues,
      current: $.current(current),
      datasource: datasource,
      includeAll: includeAll,
      hide: $.hide(hide),
      label: label,
      multi: multi,
      name: name,
      options: [],
      query: query,
      refresh: $.refresh(refresh),
      regex: regex,
      sort: sort,
      tagValuesQuery: tagValuesQuery,
      tags: [],
      tagsQuery: '',
      type: 'query',
      useTags: false,
    },
  interval(
    name,
    query,
    current,
    hide='',
    label=null,
    auto_count=300,
    auto_min='10s',
  )::
    {
      current: $.current(current),
      hide: if hide == '' then 0 else if hide == 'label' then 1 else 2,
      label: label,
      name: name,
      query: std.join(',', std.filter($.filterAuto, std.split(query, ','))),
      refresh: 2,
      type: 'interval',
      auto: std.count(std.split(query, ','), 'auto') > 0,
      auto_count: auto_count,
      auto_min: auto_min,
    },
  hide(hide)::
    if hide == '' then 0 else if hide == 'label' then 1 else 2,
  current(current):: {
    selected: true,
    [if current != null then 'text']: current,
    [if current != null then 'value']: if current == 'auto' then
      '$__auto_interval'
    else if current == 'all' then
      '$__all'
    else
      current,
  },
  datasource(
    name,
    query,
    current,
    hide='',
    label=null,
    regex='',
    refresh='load',
  ):: {
    current: $.current(current),
    hide: $.hide(hide),
    label: label,
    name: name,
    options: [],
    query: query,
    refresh: $.refresh(refresh),
    regex: regex,
    type: 'datasource',
  },
  refresh(refresh):: if refresh == 'never'
  then
    0
  else if refresh == 'load'
  then
    1
  else if refresh == 'time'
  then
    2
  else
    refresh,
  filterAuto(str):: str != 'auto',
  custom(
    name,
    query,
    current,
    refresh='never',
    label='',
    valuelabels={},
    multi=false,
    allValues=null,
    includeAll=false,
    hide='',
  )::
    {
      allValue: allValues,
      current: $.current(current),
      options:
      (if includeAll then
        [{
          selected: if (current == 'all') then true else false,
          text: "All",
          value: "$__all"
        }]
      else [])
      + 
      std.map(
        function(i)
          {
            selected: if (i in valuelabels && valuelabels[i] == current) || (i == current) then true else false,
            text: if i in valuelabels then valuelabels[i] else i,
            value: i,
          }, std.split(query, ',')
      ),
      hide: $.hide(hide),
      includeAll: includeAll,
      label: label,
      refresh: $.refresh(refresh),
      multi: multi,
      name: name,
      query: query,
      type: 'custom',
    },

  constant(
    name,
    label='',
    hide='',
    value=''
  )::
    {
      name: name,
      label: label,
      hide: $.hide(hide),
      current: {
        selected: false,
        value: value,
        text: value,
      },
      query: value,
      options: [{
        selected: true,
        value: value,
        text: value,
      }],
      skipUrlSync: false,
      type: 'constant',
    },
}
