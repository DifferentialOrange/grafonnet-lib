{
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
   * Return an InfluxDB converter (aggregation, selector etc.)
   *
   * @param type Converter type (aggregation, selector, etc)
   * @param params List of converter params
   *
   * @return Query selected value converter
   */

  local _converter(
    type,
    params=[]
  ) = {
    type: type,
    params: params
  },

  converter(
    type,
    params
  ):: _converter(type, params),

  /**
   * Return an InfluxDB selection (part of 'Select' statement)
   *
   * @param field Selected field name
   * @param converters List of value converters
   *
   * @return Query selection
   */
  local _selection(
    field='value',
    converters=[_converter('mean')]
  ) = [_converter('field', [field])] + converters,

  selection(
    field,
    converters,
  ):: _selection(field, converters),

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
   * @param selections List of 'Select' field selections with their converters (aggregation etc.)
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
    selections=[_selection()],
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
    groupBy: [_converter("time", [group_time])] + 
      [_converter("tag", [tag_name]) for tag_name in group_tags] +
      [_converter("fill", [fill])],

    resultFormat: resultFormat,
  },
}
