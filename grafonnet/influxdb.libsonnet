local selector(type, params=[]) = {
  type: type,
  params: params
};

{
  tag(
    key,
    operator,
    value,
    condition=null
  ):: {
    key: key,
    operator: operator,
    value: value,
    [if condition != null then 'condition']: condition,
  },

  selector(
    type,
    params=[]
  ):: selector(type, params),

  selection(
    field='value',
    selectors=[]
  ):: [selector('field', [ field ])] + selectors,

  /**
   * Return an InfluxDB Target
   *
   * @param alias 'Alias By' pattern
   * @param datasource Datasource
   *
   * @param query Raw InfluxQL statement
   * @param rawQuery En/Disable raw query mode
   *
   * @param policy Tagged query 'From' policy
   * @param measurement Tagged query 'From' measurement
   *
   * @param resultFormat Format results as 'Time series' or 'Table'
   *
   * @return Panel target
   */
  target(
    alias=null,
    datasource=null,

    query=null,
    rawQuery=false,

    policy='default',
    measurement=null,
    where=[],
    selections=[],
    group_time='$__interval',
    group_tags=[],
    fill='none',

    resultFormat='time_series',
  ):: {
    [if alias != null then 'alias']: alias,
    [if datasource != null then 'datasource']: datasource,

    [if query != null then 'query']: query,
    rawQuery: rawQuery,

    policy: policy,
    [if measurement != null then 'measurement']: measurement,
    tags: where,
    selections: selections,
    groupBy: [selector("time", [group_time])] + 
      [selector("tag", [tag_name]) for tag_name in group_tags] +
      [selector("fill", [fill])],

    resultFormat: resultFormat,
  },


}
