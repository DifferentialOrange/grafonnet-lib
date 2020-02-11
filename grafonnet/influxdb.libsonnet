{
  local it = self,

  /**
   * Return an InfluxDB query tag condition
   *
   * @param key Left value
   * @param operator Comparison operator
   * @param value Right value
   * @param condition AND/OR logical condition in respect to previous tag conditions
   *
   * @return Query tag condition
   */
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

  /**
   * Return an InfluxDB converter (aggregation, selector, etc.)
   *
   * @param type Converter type (aggregation, selector, etc.)
   * @param params List of converter params
   *
   * @return Query selected value converter
   */

  converter(
    type,
    params=[]
  ):: {
    type: type,
    params: params,
  },

  /**
   * Return an InfluxDB selection (part of 'Select' statement)
   *
   * @param field Selected field name
   * @param converters List of value converters
   *
   * @return Query selection
   */
  selection(
    field='value',
    converters=[it.converter('mean')],
  ):: [it.converter('field', [field])] + converters,

  /**
   * Return an InfluxDB Target
   *
   * @param alias 'Alias By' pattern
   * @param datasource Datasource
   *
   * @param query Raw InfluxQL statement
   * @param rawQuery Enable/disable raw query mode
   *
   * @param policy Tagged query 'From' policy
   * @param measurement Tagged query 'From' measurement
   * @param where List of 'Where' query tag conditions
   * @param selections List of 'Select' field selections with their converters (aggregation, selector, etc.)
   * @param group_time 'Group by' time condition
   * @param group_tags 'Group by' tags list
   * @param fill 'Group by' missing values fill mode
   *
   * @param resultFormat Format results as 'Time series' or 'Table'
   *
   * @return Panel target
   */
  target(
    alias=null,
    datasource=null,

    query=null,
    rawQuery=null,

    policy='default',
    measurement=null,
    where=[],
    selections=[it.selection()],
    group_time='$__interval',
    group_tags=[],
    fill='none',

    resultFormat='time_series',
  ):: {
    [if alias != null then 'alias']: alias,
    [if datasource != null then 'datasource']: datasource,

    [if query != null then 'query']: query,
    [if rawQuery != null then 'rawQuery']: rawQuery,

    policy: policy,
    [if measurement != null then 'measurement']: measurement,
    tags: where,
    select: selections,
    groupBy: [it.converter('time', [group_time])] +
             [it.converter('tag', [tag_name]) for tag_name in group_tags] +
             [it.converter('fill', [fill])],

    resultFormat: resultFormat,
  },
}
